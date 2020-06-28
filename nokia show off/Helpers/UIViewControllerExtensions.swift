//
//  UIViewControllerExtensions.swift
//  nokia show off
//
//  Created by Alfredo Uzumaki on 6/20/20.
//  Copyright © 2020 Alfredo Uzumaki. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func callNumber(_ phoneNumber: String) {
        if let url = URL(string: "telprompt://\(phoneNumber)") {
            let application = UIApplication.shared
            guard application.canOpenURL(url) else {
                return
            }
            application.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func switchControllerTo(_ controller: UIViewController) {
        self.view.window?.rootViewController = controller
        self.view.window?.makeKeyAndVisible()
    }
}
