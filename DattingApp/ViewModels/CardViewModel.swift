//
//  CardViewModel.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/10/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import UIKit

protocol CardViewModelConvertable {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlign: NSTextAlignment
}
