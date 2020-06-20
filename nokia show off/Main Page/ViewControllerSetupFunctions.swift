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
        screenImageView.layer.cornerRadius = 10
    }
    
    func showMainScreen() {
        screenImageView.image = #imageLiteral(resourceName: "screen")
        dialedNumer?.removeAll()
    }
    
    func showEmptyScreen() {
        screenImageView.image = #imageLiteral(resourceName: "Empty Screen")
    }
}