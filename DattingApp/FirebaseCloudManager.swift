//
//  DatabaseManager.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/30/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import Foundation
import Firebase

class FirebaseCloudManager {
    func save(data: [String: Any], collection: String, document: String, completion: @escaping (Error?) -> Void) {
        Firestore.firestore().collection(collection).document(document).setData(data, completion: { completion($0) })
    }
}
