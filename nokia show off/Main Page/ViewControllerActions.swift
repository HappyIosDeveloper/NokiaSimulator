//
//  ViewControllerActions.swift
//  nokia show off
//
//  Created by Alfredo Uzumaki on 6/20/20.
//  Copyright © 2020 Alfredo Uzumaki. All rights reserved.
//

import UIKit
import AVKit

// MARK: - Action Function
extension ViewController {
    
    func leftFunctionButtonAction() {
        play("beep")
    }
    
    func rightFunctionButtonAction() {
        play("beep")
    }
    
    func endCallButtonAction() {
        play("beep")
        showMainScreen()
    }
    
    func callButtonAction() {
        play("beep")
        callNumber(dialingLabel.text!)
    }
    
    // MARK: - Bullshits
    func dial(number:Int) {
        showEmptyScreen()
        switch number {
        case 1...9:
            if dialedNumer == nil {
                dialedNumer = [number]
            } else {
                dialedNumer?.append(number)
            }
            play(number.description)
        case 11:
            play("0")
            if dialedNumer == nil {
                dialedNumer = [0]
            } else {
                dialedNumer?.append(0)
            }
        default:
            play((0...9).randomElement()!.description)
        }
    }
    
    func play(_ fileName: String) {
        DispatchQueue.main.async {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") {
                do {
                    self.player = try AVAudioPlayer(contentsOf: url)
                    self.player.prepareToPlay()
                    self.player.play()
                } catch let error as NSError {
                    print(error.description)
                }
            }
        }
    }
}
