//
//  HarmonizerInstrument.swift
//  Harmonizer
//
//  Created by Nicholas Arner on 10/7/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

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