//
//  ViewController.swift
//  EZAudio-Swift
//
//  Created by Syed Haris Ali on 7/9/15.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//

import UIKit



class ViewController: UIViewController, EZMicrophoneDelegate {

    //------------------------------------------------------------------------------
    // MARK: Properties
    //------------------------------------------------------------------------------
    
    @IBOutlet weak var plot: EZAudioPlotGL?;
    var microphone: EZMicrophone!;
    
    //------------------------------------------------------------------------------
    // MARK: Status Bar Style
    //------------------------------------------------------------------------------
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    //------------------------------------------------------------------------------
    // MARK: View Lifecycle
    //------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        microphone = EZMicrophone(delegate: self, startsImmediately: true);
    }
    
    //------------------------------------------------------------------------------
    // MARK: Actions
    //------------------------------------------------------------------------------
    
    @IBAction func changedPlotType(sender: UISegmentedControl) {
        var plotType: EZPlotType = EZPlotType(rawValue: sender.selectedSegmentIndex)!;
        plot?.plotType = plotType;
        switch plotType {
        case EZPlotType.Buffer:
            plot?.shouldFill = false;
            plot?.shouldMirror = false;
            break;
        case EZPlotType.Rolling:
            plot?.shouldFill = true;
            plot?.shouldMirror = true;
            break;
        default:
            break;
        }
    }

    //------------------------------------------------------------------------------
    // MARK: EZMicrophoneDelegate
    //------------------------------------------------------------------------------

    func microphone(microphone: EZMicrophone!, hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            plot?.updateBuffer(buffer[0], withBufferSize: bufferSize);
        });
    }
    
}

