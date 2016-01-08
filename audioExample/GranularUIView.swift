//
//  GranularUIView.swift
//  audioExample
//
//  Created by Chris Murphy on 1/6/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation

class GranularUIView: UIView {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch!.locationInView(self)
        
        print("what up \(point.x/self.frame.width*10) \(point.y/self.frame.height*10)")
        
   
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let appConductor = appDelegate.conductor
        
        
        appConductor.granularSynth.frequency.value =
            Float(point.x/self.frame.width*20)
        appConductor.granularSynth.mix.value =
            Float(point.y/self.frame.height)
        
        
    }
}