//
//  main.swift
//  AudioKit
//
//  Auto-generated from scripts by Aurelius Prochazka on 12/22/14.
//  Customized by Nick Arner on 12/22/14.
//
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

import Foundation

class Instrument : AKInstrument {
    
    var auxilliaryOutput = AKAudio()
    
    override init() {
        super.init()
        
        let operation = AKFMOscillator()
        connect(operation)
        
        auxilliaryOutput = AKAudio.globalParameter()
        assignOutput(auxilliaryOutput, to:operation)
    }
}

class Processor : AKInstrument {
    
    init(audioSource: AKAudio) {
        super.init()
        
        let line1 = AKLinearControl(firstPoint: 220.ak, secondPoint: 3000.ak, durationBetweenPoints: 11.ak)
        connect(line1)
        
        let line2 = AKLinearControl(firstPoint: 10.ak, secondPoint: 100.ak, durationBetweenPoints: 11.ak)
        connect(line2)
        
        let operation = AKVariableFrequencyResponseBandPassFilter(audioSource: audioSource)
        operation.cutoffFrequency = line1
        operation.bandwidth = line2
        connect(operation)
        let balance = AKBalance(audioSource: operation, comparatorAudioSource: audioSource)
        connect(balance)
        
        connect(AKAudioOutput(audioSource:balance))
    }
}

// Set Up
let instrument = Instrument()
let processor = Processor(audioSource: instrument.auxilliaryOutput)
AKOrchestra.addInstrument(instrument)
AKOrchestra.addInstrument(processor)
AKManager.sharedManager().isLogging = true
AKOrchestra.test()
processor.play()

while(AKManager.sharedManager().isRunning) {} //do nothing
println("Test complete!")