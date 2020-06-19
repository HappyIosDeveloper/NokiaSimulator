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
    @IBOutlet weak var dialingLabel: UILabel!
    @IBOutlet weak var screenImageView: UIImageView!
    @IBAction func DialPadButtonAction(_ sender: Any) {
        if let butt = sender as? UIButton {
            dial(number: butt.tag)
        }
    }
    @IBAction func leftFunctionButtonAction(_ sender: Any) {
        leftFunctionButtonAction()
    }
    @IBAction func rightFunctionButtonAction(_ sender: Any) {
        rightFunctionButtonAction()
    }
    @IBAction func callButtonAction(_ sender: Any) {
        callButtonAction()
    }
    @IBAction func endCallButtonAction(_ sender: Any) {
        endCallButtonAction()
    }
    
    var player:AVAudioPlayer!
    var dialedNumer:[Int]? {
        didSet {
            dialingLabel.text = dialedNumer!.description.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        }
    }
    
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
    
    func showMainScreen() {
        screenImageView.image = #imageLiteral(resourceName: "screen")
        dialedNumer?.removeAll()
    }
    
    func showEmptyScreen() {
        screenImageView.image = #imageLiteral(resourceName: "Empty Screen")
    }
}
