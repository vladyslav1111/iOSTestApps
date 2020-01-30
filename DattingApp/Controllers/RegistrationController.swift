//
//  RegistrationController.swift
//  DattingApp
//
//  Created by Vladyslav Tkachuk1 on 1/15/20.
//  Copyright © 2020 Vladyslav Tkachuk1. All rights reserved.
//

import UIKit
import RxSwift
import JGProgressHUD

class RegistrationController: UIViewController {
    private let disposeBag = DisposeBag()
// MARK: Properties
    private let edgeMargin: CGFloat = 50
    private let texfieldPagging: CGFloat = 16
    private let topGragientColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    private let buttomGradientColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    private let gradient = CAGradientLayer()
    private var viewModel: RegistrationViewModel
    private let registerHUD = JGProgressHUD(style: .dark)
    
// MARK: Views
    let selectPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(handleSelectingPhoto), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }()

    let fullNameTextField: UITextField = {
        let txf = RegistrationTextField(placeholder: "Enter full name", pagging: 16)
        txf.addTarget(self, action: #selector(handleTextFieldChanging), for: .editingChanged)
        return txf
    }()

    let emailField: UITextField = {
        let txf = RegistrationTextField(placeholder: "Enter email", pagging: 16)
        txf.addTarget(self, action: #selector(handleEmailTextFieldChanging), for: .editingChanged)
        txf.keyboardType = .emailAddress
        return txf
    }()

    let passwordTextField: UITextField = {
        let txf = RegistrationTextField(placeholder: "Enter password", pagging: 16)
        txf.addTarget(self, action: #selector(handlePasswordTextFieldChanging), for: .editingChanged)
        txf.isSecureTextEntry = true
        return txf
    }()

    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.layer.cornerRadius = 22
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        return button
    }()
    
// MARK: Constraints
    lazy var selectPhotoButtonWidthAnchor = selectPhotoButton.widthAnchor.constraint(equalToConstant: 275)
    lazy var selectPhotoButtonHeightAnchor = selectPhotoButton.heightAnchor.constraint(equalToConstant: 275)
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds
        self.view = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        (self.view as! UIScrollView).contentSize = .init(width: screenSize.width, height: screenSize.height)
        setupGradientLayer()
        setupLayout()
        setViewModel()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        setupNotificationObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // NotificationCenter.default.removeObserver(self)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradient.frame = view.bounds
    }
    
    func setViewModel() {
        viewModel.isFormValidObservable.subscribe(onNext: { [weak self] valid in
            if valid {
                self?.registerButton.isEnabled = true
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.registerButton.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                }
            } else {
                self?.registerButton.isEnabled = false
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.registerButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                }
            }
        }).disposed(by: disposeBag)
        
        viewModel.image
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (image) in
            guard let image = image else { return }
            self?.selectPhotoButton.setImage(image, for: .normal)
        }).disposed(by: disposeBag)
    }
    
// MARK: Stacks
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
    
// MARK: traitCollectionDidChange
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        checkTrait()
        (self.view as! UIScrollView).contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
    }

    func checkTrait() {
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
}
// MARK: Handlers
private extension RegistrationController {
    
    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleSelectingPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true)
    }
    
    func showHudWith(error: Error) {
        registerHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Registration failed"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    
    @objc func registerButtonPressed() {
        registerHUD.show(in: self.view)
        viewModel.registerUserButtonPressed {[weak self] (error) in
            guard let error = error else {
                self?.registerHUD.dismiss()
                return
            }
            self?.showHudWith(error: error)
        }
    }
    
    @objc func handleTextFieldChanging(textField: UITextField) {
        viewModel.fullName.onNext(textField.text)
    }
    
    @objc func handleEmailTextFieldChanging(textField: UITextField) {
        viewModel.email.onNext(textField.text)
    }
    
    @objc func handlePasswordTextFieldChanging(textField: UITextField) {
        viewModel.password.onNext(textField.text)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }

    @objc func handleKeyboardHide() {
        (self.view as! UIScrollView).contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
    }

    @objc func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let buttomSpace = view.frame.height - (overallStackView.frame.origin.y + overallStackView.frame.height)
        let difference = keyboardFrame.height - buttomSpace
        (self.view as! UIScrollView).contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + difference)
        (self.view as! UIScrollView).scrollIndicatorInsets = .init(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
    }
    
// MARK: Setup layout
    func setupLayout() {
        let someView = UIView()
        self.view.addSubview(someView)
        someView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        someView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        someView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        someView.addSubview(overallStackView)
        
        checkTrait()
        
        overallStackView.spacing = 8
        selectPhotoButtonHeightAnchor.isActive = true
        overallStackView.anchor(top: nil, leading: someView.leadingAnchor, bottom: nil, trailing: someView.trailingAnchor, padding: .init(top: 0, left: edgeMargin, bottom: 0, right: edgeMargin))
        overallStackView.centerYAnchor.constraint(equalTo: someView.centerYAnchor).isActive = true
    }

    func setupGradientLayer() {
        gradient.colors = [topGragientColor.cgColor, buttomGradientColor.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.bounds
    }
}

extension RegistrationController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        viewModel.image.onNext(image)
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
