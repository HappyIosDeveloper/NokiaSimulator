//
//  GeneralExtensions.swift
//  nokia show off
//
//  Created by Alfredo Uzumaki on 6/20/20.
//  Copyright © 2020 Alfredo Uzumaki. All rights reserved.
//

import Foundation
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
