//
//  Validation.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/17/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import Foundation

class Validation {
    static func validateEmail(_ text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    
    static func validatePassword(_ text: String) -> Bool {
        return text.count >= 6
    }
    
    static func validateText(_ text: String) -> Bool {
        return !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
