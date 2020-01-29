//
//  RegistrationViewModel.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/17/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import Foundation
import RxSwift

class RegistrationViewModel {
    let disposeBag = DisposeBag()
    
    var fullName: PublishSubject<String?> = PublishSubject()
    var email: PublishSubject<String?> = PublishSubject()
    var password: PublishSubject<String?> = PublishSubject()
    var isFormValidObserver: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    private var isValidFullName = false
    private var isValidEmail = false
    private var isValidPassword = false
    
    init() {
        fullName.subscribe(onNext: {[weak self] (string) in
            self?.isValidFullName = Validation.validateText(string ?? "")
            self?.isFormValidObserver.onNext(self!.isValidFullName && self!.isValidPassword && self!.isValidEmail)
        }).disposed(by: disposeBag)
        
        email.subscribe(onNext: {[weak self] (string) in
            self?.isValidEmail = Validation.validateText(string ?? "")
            self?.isFormValidObserver.onNext(self!.isValidFullName && self!.isValidPassword && self!.isValidEmail)
        }).disposed(by: disposeBag)
        
        password.subscribe(onNext: {[weak self] (string) in
            self?.isValidPassword = Validation.validateText(string ?? "")
            self?.isFormValidObserver.onNext(self!.isValidFullName && self!.isValidPassword && self!.isValidEmail)
        }).disposed(by: disposeBag)
    }
}
