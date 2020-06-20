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
    
    lazy var contacts = PhoneContacts.getContacts()
    var player:AVAudioPlayer!
    var dialedNumer:[Int]? {
        didSet {
            dialingLabel.text = dialedNumer!.description.nakedNumber()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPage()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
