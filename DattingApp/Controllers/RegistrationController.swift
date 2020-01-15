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
    let texfieldPagging: CGFloat = 16
    let topGragientColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    let buttomGradientColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    let gradient = CAGradientLayer()
    
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
        return RegistrationTextField(placeholder: "Full name", pagging: texfieldPagging)
    }
    
    var emailField: UITextField {
        let txf = RegistrationTextField(placeholder: "Email", pagging: texfieldPagging)
        txf.keyboardType = .emailAddress
        return txf
    }
    
    var passwordTextField: UITextField {
        let txf = RegistrationTextField(placeholder: "Password", pagging: texfieldPagging)
        txf.isSecureTextEntry = true
        return txf
    }
    
    var registerButton: UIButton {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        button.layer.cornerRadius = 22
        
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
        return button
    }
    
    lazy var stackView: UIStackView = {
        return UIStackView(arrangedSubviews: [
            imageButton,
            fullNameTextField,
            emailField,
            passwordTextField,
            registerButton
            ])
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradient.frame = view.bounds
    }
    
    @objc fileprivate func handleTap() {
        view.endEditing(true)
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.2) {[weak self] in
            self?.view.transform = .identity
        }
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let buttomSpace = view.frame.height - (stackView.frame.origin.y + stackView.frame.height)
        let difference = keyboardFrame.height - buttomSpace
        
        view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    fileprivate func setupLayout() {
        stackView = UIStackView(arrangedSubviews: [
            imageButton,
            fullNameTextField,
            emailField,
            passwordTextField,
            registerButton
            ])
        self.view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: edgeMargin, bottom: 0, right: edgeMargin))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupGradientLayer() {
        gradient.colors = [topGragientColor.cgColor, buttomGradientColor.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.bounds
    }
}
