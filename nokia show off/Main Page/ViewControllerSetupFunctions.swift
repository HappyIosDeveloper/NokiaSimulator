//
//  ViewControllerSetupFunctions.swift
//  nokia show off
//
//  Created by Alfredo Uzumaki on 6/20/20.
//  Copyright © 2020 Alfredo Uzumaki. All rights reserved.
//

import UIKit

extension ViewController {
    
    func setupPage() {
        play("beep")
        screenImageView.layer.cornerRadius = 10
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupBatteryMonitor()
        updateBatteryStatus()
        setupTopClock()
    }
    
    func showMainScreen() {
        dialedNumer?.removeAll()
        updateBatteryStatus()
        antenaImageView.isHidden = false
        centerNokiaLabel.isHidden = false
        menuLabel.isHidden = false
        contactslabel.isHidden = false
        updateBatteryStatus()
    }
    
    func showEmptyScreen() {
        batteryImageViews.forEach({$0.alpha = 0})
        antenaImageView.isHidden = true
        centerNokiaLabel.isHidden = true
        menuLabel.isHidden = true
        contactslabel.isHidden = true
    }
    
    // MARK: - Top Clock
    func setupTopClock() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fillTopClockLabel), userInfo: nil, repeats: true)
    }
    
    @objc func fillTopClockLabel() {
        let date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date).description
        var minutes = calendar.component(.minute, from: date).description
        if Int(hour)! < 10 {
            hour = "0" + hour
        }
        if Int(minutes)! < 10 {
            minutes = "0" + minutes
        }
        if topClockLabel.text!.contains(":") {
            topClockLabel.text = "\(hour)      \(minutes)"
        } else {
            topClockLabel.text = "\(hour):\(minutes)"
        }
    }
    
    // MARK: - Battery Functions
    
    func updateBatteryStatus() {
        batteryImageViews = batteryImageViews.sorted(by: {$0.tag < $1.tag})
        switch batteryLevel {
        case 0...0.3:
            fillBatteryLevelTill(2)
        case 0.3...0.4:
            fillBatteryLevelTill(2)
        case 0.4...0.5:
            fillBatteryLevelTill(3)
        case 0.5...0.6:
            fillBatteryLevelTill(4)
        case 0.6...0.7:
            fillBatteryLevelTill(5)
        case 0.7...1:
            fillBatteryLevelTill(6)
        default: break
        }
        if batteryState == .charging {
            playBatteryChargingAnimation()
        }
    }
    
    private func fillBatteryLevelTill(_ number:Int) {
        batteryImageViews.forEach({$0.alpha = 0})
        for i in 0...number {
            for j in 0..<batteryImageViews.count {
                if i == j { // avoides unwanted crashes
                    batteryImageViews[i].alpha = 1
                }
            }
        }
    }
    
    func playBatteryChargingAnimation(level:Int? = nil) {
        if batteryState == .charging {
            if var level = level {
                if level > 9 { level = 0 }
                fillBatteryLevelTill(level)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.playBatteryChargingAnimation(level: level + 1)
                }
            } else {
                fillBatteryLevelTill(1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.playBatteryChargingAnimation(level: 1)
                }
            }
        }
    }
}
