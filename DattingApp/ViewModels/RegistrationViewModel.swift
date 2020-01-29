//
//  RegistrationViewModel.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/17/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAuth

class RegistrationViewModel {
    private let disposeBag = DisposeBag()
    
    let fullName: PublishSubject<String?> = PublishSubject()
    let email: PublishSubject<String?> = PublishSubject()
    let password: PublishSubject<String?> = PublishSubject()
    private var isFormValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let isFormValidObservable: Observable<Bool>
    
    private var fullNameStr: String?
    private var emailStr: String?
    private var passwordStr: String?
    
    private var isValidFullName = false
    private var isValidEmail = false
    private var isValidPassword = false
    
    init() {
        isFormValidObservable = isFormValid.asObserver()
        fullName.subscribe(onNext: {[weak self] (string) in
            self?.fullNameStr = string
            self?.isValidFullName = Validation.validateText(string ?? "")
            self?.isFormValid.onNext(self!.isValidFullName && self!.isValidPassword && self!.isValidEmail)
        }).disposed(by: disposeBag)
        
        email.subscribe(onNext: {[weak self] (string) in
            self?.emailStr = string
            self?.isValidEmail = Validation.validateText(string ?? "")
            self?.isFormValid.onNext(self!.isValidFullName && self!.isValidPassword && self!.isValidEmail)
        }).disposed(by: disposeBag)
        
        password.subscribe(onNext: {[weak self] (string) in
            self?.passwordStr = string
            self?.isValidPassword = Validation.validateText(string ?? "")
            self?.isFormValid.onNext(self!.isValidFullName && self!.isValidPassword && self!.isValidEmail)
        }).disposed(by: disposeBag)
    }
    
    func createUser(completion: @escaping (Error?) -> ()) {
        guard let fullName = fullNameStr, let email = emailStr, let password = passwordStr else { return completion(nil) }
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard error == nil else { return completion(error) }
            completion(nil)
        }
    }
}
