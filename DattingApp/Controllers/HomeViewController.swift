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
    let homeVM = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topStackView.profileButton.addTarget(self, action: #selector(profileButtonPresed), for: .touchUpInside)
        setupLayout()
        dummyCardView()
    }
    
    @objc func profileButtonPresed() {
        let vc = RegistrationController(viewModel: RegistrationViewModel())
        self.present(vc, animated: true)
    }
    
    fileprivate func dummyCardView() {
        homeVM.cards.forEach { (card) in
            let dummyCardView = CardView()
            dummyCardView.cardVM = card
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

