//
//  HomeViewModel.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/15/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import Foundation

class HomeViewModel {
    var cards: [CardViewModel] = [
        CardViewModel(advertiser: Advertiser(title: "Some long text", brandName: "Some text", photoImageName: "lady5c")),
        CardViewModel(user: User(name: "Nika", profesion: "Designer", age: 18, imageNames: ["lady5c", "kelly1", "lady5c", "kelly1"])),
        CardViewModel(user: User(name: "Jane", profesion: "Dominatrix", age: 20, imageNames: ["kelly1"]))
    ]
}
