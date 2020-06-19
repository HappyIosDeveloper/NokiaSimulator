//
//  ViewController.swift
//  nokia show off
//
//  Created by Alfredo Uzumaki on 6/18/20.
//  Copyright © 2020 Alfredo Uzumaki. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var topLogoImageView: UIImageView!
    @IBOutlet weak var screenImageView: UIImageView!
    @IBAction func DialPadButtonAction(_ sender: Any) {
        if let butt = sender as? UIButton {
            dialPadButtonAction(butt)
        }
    }
    @IBAction func leftFunctionButtonAction(_ sender: Any) {
    }
    @IBAction func rightFunctionButtonAction(_ sender: Any) {
    }
    @IBAction func callButtonAction(_ sender: Any) {
    }
    @IBAction func endCallButtonAction(_ sender: Any) {
    }
    
    var player:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPage()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupPage() {
        screenImageView.layer.cornerRadius = 10
    }
}


// MARK: - Action Function
extension ViewController {
    
    func dialPadButtonAction(_ button:UIButton) {
        switch button.tag {
        case 1...9: play(button.tag.description)
        case 11: play("0")
        default: play((0...9).randomElement()!.description)
        }
    }
    
    func play(_ fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.play()
            } catch let error as NSError {
                print(error.description)
            }
        }
    }
}
