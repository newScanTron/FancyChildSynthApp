//
//  ToneGenerator.swift
//  audioExample
//
//  Created by Chris Murphy on 12/8/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

class ToneGenerator: AKInstrument {
    
    // Instrument Properties
    var toneColor  = AKInstrumentProperty(value: 0.5, minimum: 0.1, maximum: 1.0)
    var oscillatorMix = AKInstrumentProperty(value: 0.25, minimum: 0.1, maximum: 8.0)
    
    var auxilliaryOutput = AKAudio()
    
    override init() {
        super.init()
        
        // Instrument Properties

        addProperty(toneColor)
        addProperty(oscillatorMix)
        // Note Properties
        let note = ToneGeneratorNote()
        
        let adsr = AKLinearADSREnvelope()
        //init the AKFMOscillator and set some params
        let fmOscillator = AKFMOscillator()
        fmOscillator.baseFrequency = note.frequency
        fmOscillator.carrierMultiplier = toneColor.scaledBy(20.ak)
        fmOscillator.modulatingMultiplier = toneColor.scaledBy(12.ak)
        fmOscillator.modulationIndex = toneColor.scaledBy(15.ak)
        fmOscillator.amplitude = adsr.scaledBy(0.15.ak)
        //other oscillator and its params
        let otherOscillator = AKVCOscillator.presetSquareWithPWMOscillator()
        otherOscillator.frequency = note.frequency
        otherOscillator.amplitude = adsr.scaledBy(0.15.ak)
        otherOscillator.waveformType = AKVCOscillator.waveformTypeForSquare()
        auxilliaryOutput = AKAudio.globalParameter()
        //adding the mix property to effect the mix of the two oscillators
        fmOscillator.amplitude = oscillatorMix
        assignOutput(auxilliaryOutput, to: otherOscillator)
        assignOutput(auxilliaryOutput, to: fmOscillator)
    }
}

class ToneGeneratorNote: AKNote {
    
    // Note Properties
    var frequency = AKNoteProperty(minimum: 40, maximum: 1880)
    var amplitude = AKNoteProperty(minimum: 0, maximum: 1)
    override init() {
        super.init()
        addProperty(frequency)
        addProperty(amplitude)
        amplitude.value = 1.0
    }
}

class HarmonizerInstrument: AKInstrument {
    
    // INSTRUMENT DEFINITION ===================================================
    
    override init() {
        super.init()
        
        let microphone: AKAudioInput = AKAudioInput()
        
        let microphoneFFT = AKFFT(
            input: microphone,
            fftSize: 2048.ak,
            overlap: 256.ak,
            windowType: AKFFT.hannWindow(),
            windowFilterSize: 2048.ak
        )
        
        let scaledFFT = AKScaledFFT(
            signal: microphoneFFT,
            frequencyRatio: 2.ak,
            formantRetainMethod: AKScaledFFT.lifteredCepstrumFormantRetainMethod(),
            amplitudeRatio: 2.ak,
            cepstrumCoefficients: nil
        )
        
        let mixedFFT = AKMixedFFT(signal1: microphoneFFT, signal2: scaledFFT)
        
        let audioOutput = AKResynthesizedAudio(signal: mixedFFT)
        connect(audioOutput)
        
        setAudioOutput(audioOutput)
    }
}