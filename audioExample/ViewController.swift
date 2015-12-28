//
//  ViewController.swift
//  audioExample
//
//  Created by Chris Murphy on 12/8/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //harmonizer and sampaler
    let harmonizer = HarmonizerInstrument();
    let sampler = AKSampler();
    override func viewDidLoad() {
        super.viewDidLoad()
        AKOrchestra.addInstrument(harmonizer)
        // Do any additional setup after loading the view, typically from a nib.
//        let inst = AKInstrument()
//        inst.setAudioOutput(AKOscillator())
//        AKOrchestra.addInstrument(inst)
//        inst.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var conductor = Conductor()
    
   
    @IBAction func C2OctaveAct(sender: AnyObject) {
        conductor.currentOctave = 1
    }
    
    
    @IBAction func C1OctaveAct(sender: AnyObject) {
        conductor.currentOctave = 0

    }
    
    
    @IBAction func keyPressed(sender: UIButton) {
        
        let key = sender
        let index = key.tag
        
        key.backgroundColor = UIColor.greenColor()
        conductor.play(index)
        
    }
    
    @IBAction func startRecording(sender: AnyObject) {
        harmonizer.play()
        sampler.startRecordingToTrack("harmonizer")
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        harmonizer.stop()
        sampler.stopRecordingToTrack("harmonizer")
    }
    
    @IBAction func startPlaying(sender: AnyObject) {
        sampler.startPlayingTrack("harmonizer")
    }
    
    @IBAction func stopPlaying(sender: AnyObject) {
        sampler.stopPlayingTrack("harmonizer")
    }
    
    @IBAction func keyReleased(sender: UIButton) {
        
        let key = sender
        let index = key.tag
        let blackKey = (index==1 || index==3 || index==6 || index==8 || index==10)
        if  blackKey {
            key.backgroundColor = UIColor.blackColor()
        } else {
            key.backgroundColor = UIColor.whiteColor()
        }
        conductor.release(index)
        
    }
    @IBAction func amplitudeSliderValueChanged(sender: UISlider) {
        conductor.setAmplidute(sender.value)
    }
    @IBAction func reverbSliderValueChanged(sender: UISlider) {
        conductor.setReverbFeedbackLevel(sender.value)
    }
    @IBAction func toneColorSliderValueChanged(sender: UISlider) {
        conductor.setToneColor(sender.value)
    }
   

}

