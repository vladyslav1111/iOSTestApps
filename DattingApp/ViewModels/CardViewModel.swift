//
//  CardViewModel.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/10/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import UIKit
import Foundation

protocol CardViewModelConvertable {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlign: NSTextAlignment
    private var imageIndex = 0 {
        didSet {
            indexImageObserver?(UIImage(named: imageNames[imageIndex]), imageIndex)
        }
    }
    var indexImageObserver: ((UIImage?, Int) -> Void)?
    
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    func goToPreviosPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
    
    init(user: User) {
        imageNames = user.imageNames
        let attributedString = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedString.append(NSAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedString.append(NSAttributedString(string: "\n\(user.profesion)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        self.attributedString = attributedString
        self.textAlign = .left
    }
    
    init(advertiser: Advertiser) {
        imageNames = [advertiser.photoImageName]
        let attributedString = NSMutableAttributedString(string: advertiser.title, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedString.append(NSAttributedString(string: "\n\(advertiser.brandName)", attributes: [.font: UIFont.systemFont(ofSize: 28, weight: .heavy)]))
        self.attributedString = attributedString
        self.textAlign = .center
    }
}

