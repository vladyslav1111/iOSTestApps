//
//  ViewController.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/8/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let topStackView = TopNavigationStackView()
    let cardDeckView = UIView()
    let buttomStackView = HomeBottomControlsStackView()
    var cardVM: [CardViewModelConvertable] = [
        AdvertiserViewModel(advertiser: Advertiser(title: "Some long text", slogan: "Some text", imageName: "lady5c")),
        UserViewModel(user: User(name: "Nika", profesion: "Designer", age: 18, imageNames: ["lady5c"])),
        UserViewModel(user: User(name: "Jane", profesion: "Dominatrix", age: 20, imageNames: ["kelly1"]))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        dummyCardView()
    }
    
    fileprivate func dummyCardView() {
        cardVM.forEach { (card) in
            let dummyCardView = CardView()
            dummyCardView.cardVM = card.toCardViewModel()
            self.cardDeckView.addSubview(dummyCardView)
            dummyCardView.fillSuperview()
        }
    }

    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardDeckView, buttomStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        overallStackView.bringSubviewToFront(cardDeckView)
    }

}

