//
//  RegistrationController.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/15/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    let edgeMargin: CGFloat = 30
    let topGragientColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    let buttomGradientColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    
    var imageButton: UIButton {
        let button = UIButton()
        button.setTitle("Select photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        
        button.heightAnchor.constraint(equalToConstant: view.frame.width - edgeMargin * 2).isActive = true
        return button
    }
    
    var fullNameTextField: UITextField {
        let txf = RegistrationTextField(placeholder: "Full name", pagging: 16)
        return txf
    }
    
    var emailField: UITextField {
        let txf = RegistrationTextField(placeholder: "Email", pagging: 16)
        txf.keyboardType = .emailAddress
        return txf
    }
    
    var passwordTextField: UITextField {
        let txf = RegistrationTextField(placeholder: "Password", pagging: 16)
        txf.isSecureTextEntry = true
        return txf
    }
    
    var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        
        stackView = UIStackView(arrangedSubviews: [
            imageButton,
            fullNameTextField,
            emailField,
            passwordTextField
            ])
        self.view.addSubview(stackView)
        setupLayerForStackView()
    }
    
    func setupLayerForStackView() {
        guard stackView != nil else { return }
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: edgeMargin, bottom: 0, right: edgeMargin))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [topGragientColor.cgColor, buttomGradientColor.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.bounds
    }

}
