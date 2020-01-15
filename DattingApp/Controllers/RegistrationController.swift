//
//  RegistrationController.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/15/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    let edgeMargin: CGFloat = 50
    let texfieldPagging: CGFloat = 16
    let topGragientColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    let buttomGradientColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    let gradient = CAGradientLayer()

    var selectPhotoButton: UIButton {
        let button = UIButton()
        button.setTitle("Select photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
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
    lazy var selectPhotoButtonWidthAnchor = selectPhotoButton.widthAnchor.constraint(equalToConstant: 275)
    lazy var selectPhotoButtonHeightAnchor = selectPhotoButton.heightAnchor.constraint(equalToConstant: 275)

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
    
    lazy var verticalStackView: UIStackView = {
        let uiStack = UIStackView(arrangedSubviews: [
            fullNameTextField,
            emailField,
            passwordTextField,
            registerButton
            ])
        uiStack.axis = .vertical
        uiStack.spacing = 8
        return uiStack
    }()
    
    lazy var overallStackView: UIStackView = UIStackView(arrangedSubviews: [
            selectPhotoButton,
            verticalStackView
            ])

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact {
            overallStackView.axis = .horizontal
            verticalStackView.distribution = .fillEqually
            selectPhotoButtonHeightAnchor.isActive = false
            selectPhotoButtonWidthAnchor.isActive = true
        } else {
            overallStackView.axis = .vertical
            verticalStackView.distribution = .fill
            selectPhotoButtonWidthAnchor.isActive = false
            selectPhotoButtonHeightAnchor.isActive = true
        }
    }

    func checkTrait() {
        if traitCollection.verticalSizeClass == .compact {
            overallStackView.axis = .horizontal
        } else {
            overallStackView.axis = .vertical
        }
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
        let buttomSpace = view.frame.height - (overallStackView.frame.origin.y + overallStackView.frame.height)
        let difference = keyboardFrame.height - buttomSpace

        view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }

    fileprivate func setupLayout() {
        self.view.addSubview(overallStackView)
        overallStackView.axis = .vertical
        overallStackView.spacing = 8
        overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: edgeMargin, bottom: 0, right: edgeMargin))
        overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    fileprivate func setupGradientLayer() {
        gradient.colors = [topGragientColor.cgColor, buttomGradientColor.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.bounds
    }
    
//    let selectPhotoButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Select Photo", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
//        button.backgroundColor = .white
//        button.setTitleColor(.black, for: .normal)
//        button.layer.cornerRadius = 16
//        button.imageView?.contentMode = .scaleAspectFill
//        button.clipsToBounds = true
//        return button
//    }()
//
//
//
//    lazy var selectPhotoButtonWidthAnchor = selectPhotoButton.widthAnchor.constraint(equalToConstant: 275)
//    lazy var selectPhotoButtonHeightAnchor = selectPhotoButton.heightAnchor.constraint(equalToConstant: 275)
//
//    let fullNameTextField: RegistrationTextField = {
//        let tf = RegistrationTextField(placeholder: "Password", pagging: 16)
//        tf.placeholder = "Enter full name"
//
//        return tf
//    }()
//    let emailTextField: RegistrationTextField = {
//        let tf = RegistrationTextField(placeholder: "Password", pagging: 16)
//        tf.placeholder = "Enter email"
//        tf.keyboardType = .emailAddress
//
//        return tf
//    }()
//    let passwordTextField: RegistrationTextField = {
//        let tf = RegistrationTextField(placeholder: "Password", pagging: 16)
//        tf.placeholder = "Enter password"
//        tf.isSecureTextEntry = true
//
//        return tf
//    }()
//
//    let registerButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Register", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
//        button.backgroundColor = .lightGray
//        button.setTitleColor(.gray, for: .disabled)
//        button.isEnabled = false
//        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        button.layer.cornerRadius = 22
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupGradientLayer()
//        setupLayout()
//        setupNotificationObservers()
//        setupTapGesture()
//    }
//    fileprivate func setupTapGesture() {
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
//    }
//
//    @objc fileprivate func handleTapDismiss() {
//        self.view.endEditing(true)
//    }
//
//    fileprivate func setupNotificationObservers() {
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    @objc fileprivate func handleKeyboardHide() {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.view.transform = .identity
//        })
//    }
//
//    @objc fileprivate func handleKeyboardShow(notification: Notification) {
//        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
//        let keyboardFrame = value.cgRectValue
//        let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
//        let difference = keyboardFrame.height - bottomSpace
//        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
//    }
//
//    lazy var verticalStackView: UIStackView = {
//        let sv = UIStackView(arrangedSubviews: [
//            fullNameTextField,
//            emailTextField,
//            passwordTextField,
//            registerButton
//            ])
//        sv.axis = .vertical
//        sv.spacing = 8
//        return sv
//    }()
//
//    lazy var overallStackView = UIStackView(arrangedSubviews: [
//        selectPhotoButton,
//        verticalStackView
//        ])
//
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        if self.traitCollection.verticalSizeClass == .compact {
//            overallStackView.axis = .horizontal
//            verticalStackView.distribution = .fillEqually
//            selectPhotoButtonHeightAnchor.isActive = false
//            selectPhotoButtonWidthAnchor.isActive = true
//        } else {
//            overallStackView.axis = .vertical
//            verticalStackView.distribution = .fill
//            selectPhotoButtonWidthAnchor.isActive = false
//            selectPhotoButtonHeightAnchor.isActive = true
//        }
//    }
//
//
//    fileprivate func setupLayout() {
//        view.addSubview(overallStackView)
//        overallStackView.axis = .vertical
//        overallStackView.spacing = 8
//        overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
//        overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//    }
//
//    let gradientLayer = CAGradientLayer()
//
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        gradientLayer.frame = view.bounds
//    }
//
//    fileprivate func setupGradientLayer() {
//
//        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
//        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
//        // make sure to user cgColor
//        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
//        gradientLayer.locations = [0, 1]
//        view.layer.addSublayer(gradientLayer)
//        gradientLayer.frame = view.bounds
//    }
}
