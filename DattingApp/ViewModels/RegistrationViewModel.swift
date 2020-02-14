//
//  RegistrationViewModel.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/17/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

class RegistrationViewModel {
    private let disposeBag = DisposeBag()
    
    let image: PublishSubject<UIImage?> = PublishSubject()
    let fullName: PublishSubject<String?> = PublishSubject()
    let email: PublishSubject<String?> = PublishSubject()
    let password: PublishSubject<String?> = PublishSubject()
    private var isFormValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let isFormValidObservable: Observable<Bool>
    
    private var uiImage: UIImage?
    private var fullNameStr: String?
    private var emailStr: String?
    private var passwordStr: String?
    
    private var isValidFullName = false
    private var isValidEmail = false
    private var isValidPassword = false
    
    private let fileStorageManager: FileStorageManager
    
    init(storage: FileStorageManager) {
        fileStorageManager = storage
        isFormValidObservable = isFormValid.asObserver()
        image.subscribe(onNext: {[weak self] (image) in
            self?.uiImage = image
        }).disposed(by: disposeBag)
        
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
    
    func registerUserButtonPressed(completion: @escaping (Error?) -> ()) {
        guard let fullName = fullNameStr, let email = emailStr, let password = passwordStr else { return completion( RegistrationError.emptyFieldError) }
        guard let uiImage = self.uiImage else { return completion(RegistrationError.notPickedImage)}
        FireAuthManager.shared.registerUser(withEmail: email, password: password) { [weak self] (error) in
            guard error == nil else { return completion(error) }
            let imgUid = UUID().uuidString
            self?.fileStorageManager.saveImage(uiImage, withName: imgUid, completion: { [weak self] error in
                guard error == nil else { return completion(error)}
                self?.fileStorageManager.downloadURL(withPath: "/\(uiImage)/\(imgUid)", { (imageUrl, error) in
                    let uid = Auth.auth().currentUser?.uid ?? ""
                    let data = ["fullName": fullName, "email": email, "uid": uid, "imageUrl1": imageUrl?.absoluteString ?? ""]
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: { completion($0) })
                })
            })
        }
    }
}
