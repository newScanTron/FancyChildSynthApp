//
//  ViewController.swift
//  audioExample
//
//  Created by Chris Murphy on 12/8/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
  
    @IBOutlet weak var granularLabel1: UILabel!
    @IBOutlet weak var granularLabel2: UILabel!
    
  
    @IBAction func granularGo(sender: AnyObject) {
        appDel.conductor.isGranular = true
    }
    @IBAction func freqGo(sender: AnyObject) {
        appDel.conductor.isGranular = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
          let appConductor = appDel.conductor
        
        AKOrchestra.addInstrument(appConductor.harmonizer)
        AKOrchestra.addInstrument(appConductor.granularSynth)

    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
   
//        let touch = touches.first
//        let point = touch!.locationInView(self.view)
//        print("location in view: \(point.x) \(point.y)")
    }
    
    @IBAction func C2OctaveAct(sender: AnyObject) {
        if appDel.conductor.currentOctave <= 5
        {
            appDel.conductor.currentOctave++
        }
    }
    
    
    @IBAction func C1OctaveAct(sender: AnyObject) {
        if appDel.conductor.currentOctave >= 1
        {
            appDel.conductor.currentOctave--
        }
    }
    
    
    @IBAction func keyPressed(sender: UIButton) {
        
        let key = sender
        let index = key.tag
        
        key.backgroundColor = UIColor.greenColor()
        appDel.conductor.play(index)
        
    }
    
    @IBAction func startRecording(sender: AnyObject) {
        appDel.conductor.harmonizer.play()
        appDel.conductor.sampler.startRecordingToTrack("harmonizer")
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        appDel.conductor.harmonizer.stop()
        appDel.conductor.sampler.stopRecordingToTrack("harmonizer")
    }
    
    @IBAction func startPlaying(sender: AnyObject) {
        appDel.conductor.sampler.startPlayingTrack("harmonizer")
    }
    
    @IBAction func stopPlaying(sender: AnyObject) {
        appDel.conductor.sampler.stopPlayingTrack("harmonizer")
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
        appDel.conductor.release(index)
        
    }
    @IBAction func amplitudeSliderValueChanged(sender: UISlider) {
        appDel.conductor.setAmplidute(sender.value)
    }
    @IBAction func reverbSliderValueChanged(sender: UISlider) {
        appDel.conductor.setReverbFeedbackLevel(sender.value)
    }
    @IBAction func toneColorSliderValueChanged(sender: UISlider) {
        appDel.conductor.setToneColor(sender.value)
    }
   

}

