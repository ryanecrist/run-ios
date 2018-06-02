//
//  Coach.swift
//  RunTastic
//
//  Created by Ryan Crist on 6/2/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import AVFoundation
import Foundation

class Coach {
    
    // MARK: - Private Properties
    
    private let _synthesizer = AVSpeechSynthesizer()
    
    // MARK: - Public Methods
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        _synthesizer.speak(utterance)
    }
}
