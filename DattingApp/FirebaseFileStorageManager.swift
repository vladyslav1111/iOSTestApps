//
//  FileStorageManager.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/30/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import Foundation
import Firebase

protocol FileStorageManager {
    func saveFile(_ data: Data, to: String, withName: String, completion: @escaping (Error?)->Void)
    func saveImage(_ image: UIImage, withName name: String, completion: @escaping (Error?)->Void)
    func downloadURL(withPath path: String, _ completion: @escaping (URL?, Error?)->Void)
}

class FirebaseFileStorageManager: FileStorageManager {
    static let instance = FirebaseFileStorageManager()
    private init() {}
    
    func saveImage(_ image: UIImage, withName name: String = UUID().uuidString, completion: @escaping (Error?)->Void) {
        let imageData = image.jpegData(compressionQuality: 0.75) ?? Data()
        self.saveFile(imageData, to: "images", withName: name) { completion($0) }
    }
    
    func saveFile(_ data: Data, to path: String, withName name: String, completion: @escaping (Error?)->Void) {
        let ref = Storage.storage().reference(withPath: "/\(path)/\(name)")
        ref.putData(data, metadata: nil, completion: { completion($1) })
    }
    
    func downloadURL(withPath path: String, _ completion: @escaping (URL?, Error?)->Void) {
        let ref = Storage.storage().reference(withPath: "/\(path))")
        ref.downloadURL(completion: { completion($0, $1) })
    }
}
