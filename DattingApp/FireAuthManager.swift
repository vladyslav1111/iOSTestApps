//
//  AuthManager.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/30/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import Foundation
import Firebase

enum RegistrationError: String, Error {
    case emptyFieldError = "Fill all fields"
    case imageUploadError = "Failed to upload the image"
    case notPickedImage = "The image was not picked"
    case registrationFailed = "Registration failed"
    case unknownError = "Unknown error"
}

class FireAuthManager {
    static let shared = FireAuthManager()
    var currentUser: CurrentUser?
    private init() {}
    private var fireUser: Firebase.User?
    private var fireCredential: Firebase.AuthCredential?
    
    var refreshToken: String? {
        return fireUser?.refreshToken
    }
    
    func registerUser(withEmail email: String, password: String, _ completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            guard error == nil else { return completion(error) }
            guard let result = result else { return completion(RegistrationError.unknownError)}
            self?.fireUser = result.user
            self?.fireCredential = result.credential
            self?.currentUser = CurrentUser(uid: result.user.uid, email: result.user.email)
            completion(nil)
        }
    }
}
