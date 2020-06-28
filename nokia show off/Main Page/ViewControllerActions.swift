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
        gotoContacts()
    }
    
    @objc func endCallButtonAction() {
        play("beep")
        showMainScreen()
    }
    
    func callButtonAction() {
        play("beep")
        callNumber(dialingLabel.text!)
    }
    
    // MARK: - Bullshits
    func gotoContacts() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
        switchControllerTo(vc)
    }
    
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
    
    // MARK: - Battery Functions
    func setupBatteryMonitor() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange), name: UIDevice.batteryStateDidChangeNotification, object: nil)
    }
    
    @objc func batteryLevelDidChange(_ notification: Notification) {
        updateBatteryStatus()
    }

    @objc func batteryStateDidChange(_ notification: Notification) {
        updateBatteryStatus()
        switch batteryState {
        case .unplugged, .unknown:
            print("not charging")
        case .charging, .full:
            print("charging or full")
        @unknown default: break
        }
    }
}
