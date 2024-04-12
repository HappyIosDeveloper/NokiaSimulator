//
//  GeneralExtensions.swift
//  nokia show off
//
//  Created by Alfredo Uzumaki on 6/20/20.
//  Copyright © 2020 Alfredo Uzumaki. All rights reserved.
//

import UIKit
import NaturalLanguage

extension String {
    func nakedNumber()-> String {
        return self.description.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
    }
    
    func isEnglish()-> Bool {
        switch detectedLanguage(for: self)!.lowercased() {
        case "arabic", "persian", "chinese", "japanese", "korean", "thai", "hindi", "malay": return false
        default: return true
        }
    }
    
    func detectedLanguage<T: StringProtocol>(for string: T) -> String? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(String(string))
        guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
        let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
        return detectedLanguage
    }
}

extension UIDevice {
    
    // Get this value after sceneDidBecomeActive
    var hasDynamicIsland: Bool {
        // 1. dynamicIsland only support iPhone
        guard userInterfaceIdiom == .phone else {
            return false
        }
        // 2. Get key window, working after sceneDidBecomeActive
        guard let window = (UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.flatMap { $0.windows }.first { $0.isKeyWindow}) else {
            print("Do not found key window")
            return false
        }
        // 3.It works properly when the device orientation is portrait
        return window.safeAreaInsets.top >= 51
    }
}
