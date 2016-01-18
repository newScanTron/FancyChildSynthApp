//
//  GranularSynth.swift
//  SwiftGranularSynthTest
//
//  Created by Aurelius Prochazka on 2/16/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

class GranularSynth: AKInstrument
{
    // INSTRUMENT CONTROLS =====================================================
    
    var mix = AKInstrumentProperty(
        value:    0.5,
        minimum:  0,
        maximum:  1
    )
    var frequency = AKInstrumentProperty(
        value:    0.2,
        minimum:  0.01,
        maximum:  10
    )
    var duration = AKInstrumentProperty(
        value:    10,
        minimum:   0.1,
        maximum:  20
    )
    var density = AKInstrumentProperty(
        value:    1,
        minimum:  0.1,
        maximum:  2
    )
    var frequencyVariation = AKInstrumentProperty(
        value:    10,
        minimum:   0.1,
        maximum:  20
    )
    var frequencyVariationDistribution = AKInstrumentProperty(
        value:    10,
        minimum:   0.1,
        maximum:  20
    )
    
    // INSTRUMENT DEFINITION ===================================================
    var isPlaying = false
    override init() {
        super.init()
        
        addProperty(mix)
        addProperty(frequency)
        addProperty(duration)
        addProperty(density)
        addProperty(frequencyVariation)
        addProperty(frequencyVariationDistribution)
        
        let file = AKManager.pathToSoundFile("PianoBassDrumLoop", ofType: "wav")
        
        let soundFile = AKSoundFileTable(filename: file, size: 16384)
        
        let synth =  AKGranularSynthesizer(
            grainWaveform: soundFile,
            frequency: frequency
        )
        synth.duration = duration
        synth.density = density
        synth.frequencyVariation = frequencyVariation
        synth.frequencyVariationDistribution = frequencyVariationDistribution
        
        let file2 = AKManager.pathToSoundFile("808loop", ofType: "wav")
        
        let soundFile2 = AKSoundFileTable(filename: file2, size:16384)
        
        let synth2 =  AKGranularSynthesizer(
            grainWaveform: soundFile2,
            frequency: frequency
        )
        synth2.duration = duration
        synth2.density = density
        synth2.frequencyVariation = frequencyVariation
        synth2.frequencyVariationDistribution = frequencyVariationDistribution
        
        let mixer = AKMix(input1: synth, input2: synth2, balance: mix)
        
        setAudioOutput(mixer.scaledBy(0.5.ak))
        
    }
}