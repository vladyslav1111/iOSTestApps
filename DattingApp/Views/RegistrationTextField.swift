//
//  RegistrationTextField.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/15/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import UIKit

class RegistrationTextField: UITextField {
    let pagging: CGFloat
    let height: CGFloat = 50
    
    init(placeholder: String, pagging: CGFloat) {
        self.pagging = pagging
        super.init(frame: .zero)
        self.placeholder = placeholder
        backgroundColor = .white
        self.layer.cornerRadius = self.height / 2
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: pagging, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: pagging, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
