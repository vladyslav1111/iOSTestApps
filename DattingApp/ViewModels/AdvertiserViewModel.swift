//
//  AdvertiserViewModel.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/14/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import UIKit

struct AdvertiserViewModel {
    private let advertiser: Advertiser
    init(advertiser: Advertiser) {
        self.advertiser = advertiser
    }
    
    var imageName: String {
        return advertiser.imageName
    }
    
    var attributedString: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: advertiser.title, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedString.append(NSAttributedString(string: "\n\(advertiser.slogan)", attributes: [.font: UIFont.systemFont(ofSize: 28, weight: .heavy)]))
        return attributedString
    }
    
    var textAlign: NSTextAlignment {
        return .center
    }
}

extension AdvertiserViewModel: CardViewModelConvertable {
    func toCardViewModel() -> CardViewModel {
        return CardViewModel(imageNames: [imageName], attributedString: attributedString, textAligh: textAlign)
    }
    
    
}
