//
//  TopNavigationStackView.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/9/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {
    let profileButton = UIButton()
    let fireImage = UIImageView(image: #imageLiteral(resourceName: "3 7"))
    let messageButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .equalCentering
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        fireImage.contentMode = .scaleAspectFit
        profileButton.setImage(#imageLiteral(resourceName: "3 6").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "3 8").withRenderingMode(.alwaysOriginal), for: .normal)
        [profileButton, fireImage, messageButton].forEach { (item) in
            addArrangedSubview(item)
        }
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
