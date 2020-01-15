//
//  User.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/10/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import UIKit

struct User: CardViewModelConvertable{
    let name: String
    let profesion: String
    let age: Int
    let imageName: String
    
    func toCardViewModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedString.append(NSAttributedString(string: " \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedString.append(NSAttributedString(string: "\n\(profesion)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        return CardViewModel(imageName: imageName, attributedString: attributedString, textAlign: .left)
    }
}
