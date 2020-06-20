//
//  GeneralExtensions.swift
//  nokia show off
//
//  Created by Alfredo Uzumaki on 6/20/20.
//  Copyright © 2020 Alfredo Uzumaki. All rights reserved.
//

import Foundation

extension String {
    func nakedNumber()-> String {
        return self.description.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
    }
}
