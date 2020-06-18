//
//  ViewController.swift
//  nokia show off
//
//  Created by Alfredo Uzumaki on 6/18/20.
//  Copyright © 2020 Alfredo Uzumaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topLogoImageView: UIImageView!
    @IBOutlet weak var screenImageView: UIImageView!
    
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

