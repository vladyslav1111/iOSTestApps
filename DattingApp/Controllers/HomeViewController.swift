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
    let cardView = UIView()
    let buttomStackView = HomeBottomControlsStackView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        dummyCardView()
    }
    
    fileprivate func dummyCardView() {
        let dummyCardView = CardView()
        self.cardView.addSubview(dummyCardView)
        dummyCardView.fillSuperview()
    }

    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardView, buttomStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        overallStackView.bringSubviewToFront(cardView)
    }

}

