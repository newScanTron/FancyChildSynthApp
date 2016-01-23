//
//  Conductor.swift
//  SwiftKeyboard
//
//  Created by Aurelius Prochazka on 11/28/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//


class Conductor {
    //bool to tell weather granular or freq is selected 
    var isGranular = false
    var toneGenerator = ToneGenerator()
       let sampler = AKSampler()
    //harmonizer and sampaler
    let harmonizer = HarmonizerInstrument()
     let granularSynth = GranularSynth()
    
    var fx: EffectsProcessor
    var currentNotes = [ToneGeneratorNote](count: 13, repeatedValue: ToneGeneratorNote())
    let aFreq = [27.5, 55.0, 110.0, 220.0, 440.0, 880.0, 1760.0]
    var currentOctave = 1
    init() {
        AKOrchestra.addInstrument(toneGenerator)
        fx = EffectsProcessor(audioSource: toneGenerator.auxilliaryOutput)
        AKOrchestra.addInstrument(fx)
        AKOrchestra.start()

        fx.play()
    }
    func giveFrequency(note: Int) -> Float
    {
        
        let twelveRoot = 1.059463094359
        let result = Float(aFreq[self.currentOctave] * pow(twelveRoot, Double(note)))
        return result
    }
    func play(key: Int) {
        let note = ToneGeneratorNote()
       // let frequency = Float(frequencies[currentOctave][key])
        note.frequency.value = giveFrequency(key)
        toneGenerator.playNote(note)
        currentNotes[key]=note;
    }

    func release(key: Int) {
        let noteToRelease = currentNotes[key]
        noteToRelease.stop()
    }

    func setReverbFeedbackLevel(feedbackLevel: Float) {
        fx.feedbackLevel.value = feedbackLevel
    }
    func setToneColor(toneColor: Float) {
        toneGenerator.toneColor.value = toneColor
    }
    func setAmplidute(amp: Float)
    {
        toneGenerator.oscillatorMix.value = amp
    }
}
