//
//  UserViewModel.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/14/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import UIKit

struct UserViewModel {
    private let user: User
    init(user: User) {
        self.user = user
    }
    
    var imageNames: [String] {
        return user.imageNames
    }
    
    var attributedString: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedString.append(NSAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedString.append(NSAttributedString(string: "\n\(user.profesion)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        return attributedString
    }
    
    var textAlign: NSTextAlignment {
        return .left
    }
}

extension UserViewModel: CardViewModelConvertable {
    func toCardViewModel() -> CardViewModel {
        return CardViewModel(imageNames: imageNames, attributedString: attributedString, textAligh: textAlign)
    }
}
