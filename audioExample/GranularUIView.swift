//
//  GranularUIView.swift
//  audioExample
//
//  Created by Chris Murphy on 1/6/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation

import QuartzCore
import UIKit

class GranularUIView: UIView {
     let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    var infoLabel = UILabel()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.shadowColor = UIColor(colorLiteralRed: 0.5, green: 0.6, blue: 0.9, alpha: 0.8).CGColor
        layer.shadowRadius = 12.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
         infoLabel  = UILabel(frame: CGRect(x: 5.0, y: 5.0, width: self.frame.maxX, height: self.frame.maxY))
        
        infoLabel.text = "Tap with Two fingers to expand"
        self.addSubview(infoLabel)
        
        
        //layer.shadowOpacity = 1.0
    }
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        layer.borderColor = UIColor.blueColor().CGColor
        layer.borderWidth = 12.0
        layer.shadowOpacity = 1.0
    }

   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        multipleTouchEnabled = true
        
        
        let touch = touches.first
        print("touches: \(touches.count)" )
        let point = touch!.locationInView(self)
        let blue = UIColor(red: 41.0/255.0,
            green: 0.5,
            blue: 185/255.0,
            alpha: 1.0)
        
        if touches.count > 1
        {
            print("what up \(point.x/self.frame.width*10) \(point.y/self.frame.height*10)")
            if appDel.conductor.granularSynth.isPlaying
            {
                appDel.conductor.granularSynth.stop()
                appDel.conductor.granularSynth.isPlaying = false
                layer.shadowOpacity = 0.0
                UIView.animateWithDuration(2, animations: {
                    
                    self.frame =
                        CGRect(x: self.frame.minX, y: self.frame.minY , width: 100, height: 100)
                    self.backgroundColor = blue
                })
            }
            else
            {
                infoLabel.removeFromSuperview()
                appDel.conductor.granularSynth.play()
                appDel.conductor.granularSynth.isPlaying = true
                layer.shadowOpacity = 1.0
                UIView.animateWithDuration(2, animations: {
                    self.frame =
                        CGRect(x: self.frame.minX , y: self.frame.minY , width: 375, height: 248)
                    self.backgroundColor = blue
                })
            }
        }
   
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let appConductor = appDelegate.conductor
        
        
        appConductor.granularSynth.frequency.value =
            Float(point.x/self.frame.width*20)
        appConductor.granularSynth.mix.value =
            Float(point.y/self.frame.height)
        appConductor.granularSynth.duration.value =
            Float(point.x/self.frame.width*20)
        
        layer.shadowColor = UIColor(colorLiteralRed: 0.5, green:  Float(point.x/self.frame.width), blue:  Float(point.y/self.frame.height), alpha: 0.8).CGColor
        
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
   
        let touch = touches.first
        let point = touch!.locationInView(self)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let appConductor = appDelegate.conductor
        
        
        appConductor.granularSynth.frequency.value =
            Float(point.x/self.frame.width*20)
        appConductor.granularSynth.mix.value =
            Float(point.y/self.frame.height)
        appConductor.granularSynth.duration.value =
            Float(point.x/self.frame.width*20)
        
        layer.shadowColor = UIColor(colorLiteralRed: 0.5, green:  Float(point.x/self.frame.width), blue:  Float(point.y/self.frame.height), alpha: 0.8).CGColor
        
    }
}