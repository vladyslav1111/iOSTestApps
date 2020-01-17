//
//  RegistrationViewModel.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/17/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import Foundation

class RegistrationViewModel {
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? {
        didSet {
            checkFormValidity()
        }
    }
    var password: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    fileprivate func checkFormValidity() {
        let nameValid = Validation.validateText(fullName ?? "")
        let emailValid = Validation.validateEmail(email ?? "")
        let passwordValid = Validation.validatePassword(password ?? "")
        
        isFormValidObserver?(nameValid && emailValid && passwordValid)
    }
    
    var isFormValidObserver: ((Bool) -> ())?
}
