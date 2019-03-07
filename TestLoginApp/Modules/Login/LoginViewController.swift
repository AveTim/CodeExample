//
//  LoginViewController.swift
//  TestLoginApp
//
//  Created by Tim on 3/6/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: Properties
    var output: LoginViewOutput!

    // MARK: Outlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var loginContentView: UIView!

    @IBOutlet private weak var emailTitleLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    
    @IBOutlet private weak var passwordTitleLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registrationButton: UIButton!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupUI()
        setupKeyboard()
        
        output.viewIsReady()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        forgotPasswordButton.layer.cornerRadius = C.ForgotPasswordButton.cornerRadius
        loginButton.layer.cornerRadius = loginButton.bounds.height * 0.5
    }
    
    // MARK: UI
    private func setupScrollView() {
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.contentSize = loginContentView.frame.size
    }
    
    private func setupUI() {
        navigationItem.title = String.Auth.title.localized()
        
        // Email
        emailTitleLabel.text = String.Auth.EnterEmail.title.localized()
        emailTitleLabel.font = UIFont.textStyle4
        emailTitleLabel.textColor = .warmGrey
        
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.font = UIFont.textStyle3
        emailTextField.attributedPlaceholder = NSAttributedString(string: String.Auth.EnterEmail.placeholder.localized(),
                                                                  attributes: [ .foregroundColor: UIColor.lightGray,
                                                                                .font: UIFont.textStyle3 ])
        
        // Password
        passwordTitleLabel.text = String.Auth.EnterPassword.title.localized()
        passwordTitleLabel.font = UIFont.textStyle4
        passwordTitleLabel.textColor = .warmGrey
        
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.font = UIFont.textStyle3
        passwordTextField.attributedPlaceholder = NSAttributedString(string: String.Auth.EnterPassword.placeholder.localized(),
                                                                     attributes: [ .foregroundColor: UIColor.lightGray,
                                                                                   .font: UIFont.textStyle3 ])
        // Forgot password
        forgotPasswordButton.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
        forgotPasswordButton.layer.borderWidth = C.ForgotPasswordButton.borderWidth
        forgotPasswordButton.setTitle(String.Auth.ForgotPasswordButton.title.localized(),
                                      for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.textStyle6
        forgotPasswordButton.tintColor = .warmGrey
        forgotPasswordButton.contentEdgeInsets = UIEdgeInsets.init(top: C.ForgotPasswordButton.Insents.top,
                                                                   left: C.ForgotPasswordButton.Insents.left,
                                                                   bottom: C.ForgotPasswordButton.Insents.bottom,
                                                                   right: C.ForgotPasswordButton.Insents.right)
        
        // Login
        loginButton.backgroundColor = .tangerine
        loginButton.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
        loginButton.layer.masksToBounds = true
        loginButton.setTitle(String.Auth.LoginButton.title.localized(),
                             for: .normal)
        loginButton.titleLabel?.font = .textStyle5
        loginButton.tintColor = .customWhite
        loginButton.contentEdgeInsets = UIEdgeInsets.init(top: C.LoginButton.Insents.top,
                                                          left: C.LoginButton.Insents.left,
                                                          bottom: C.LoginButton.Insents.bottom,
                                                          right: C.LoginButton.Insents.right)
        
        // Registration
        registrationButton.titleLabel?.font = .textStyle2
        registrationButton.tintColor = .windowsBlue
        registrationButton.setTitle(String.Auth.RegistrationButton.title.localized(),
                                    for: .normal)
        registrationButton.contentEdgeInsets = UIEdgeInsets(top: -1, left: 0, bottom: 1, right: 0) // else bug with button's height
    }
    
    private func setupKeyboard() {
        // hide by click outside
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: Actions
    @IBAction private func didTapForgotPassword(_ sender: UIButton) {
        output.didTapForgotPassword()
    }
    
    @IBAction private func didTapLogin(_ sender: UIButton) {
        output.didTapLogin(email: emailTextField.text,
                           password: passwordTextField.text)
    }
    
    @IBAction private func didTapRegistration(_ sender: UIButton) {
        output.didTapRegistration()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Keyboard scrolling
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let bottomInset: CGFloat
        if #available(iOS 11, *) {
            bottomInset = keyboardSize.height
        } else {
            bottomInset = keyboardSize.height - topDistance
        }
        
        let keyboardContentInsets = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        UIView.animate(withDuration: TimeInterval(C.Keyboard.animationDuration)) { [weak self] in
            guard let `self` = self else { return }
            self.scrollView.contentInset = keyboardContentInsets
            self.scrollView.scrollIndicatorInsets = keyboardContentInsets
            
            self.scrollView.scrollRectToVisible(self.loginContentView.frame, animated: true)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: TimeInterval(C.Keyboard.animationDuration)) { [weak self] in
            self?.scrollView.contentInset = UIEdgeInsets.zero
            self?.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        }
    }
    
}

// MARK: - LoginViewInput
extension LoginViewController: LoginViewInput {
    
}

// MARK: - Constants
private enum C {
    
    enum Keyboard {
        static let animationDuration: Double = 0.3
    }
    
    enum ForgotPasswordButton {
        static let cornerRadius: CGFloat = 4
        static let borderWidth: CGFloat = 0.5
        
        enum Insents {
            static let top: CGFloat = 7
            static let right: CGFloat = 9
            static let bottom: CGFloat = 5
            static let left: CGFloat = 10
        }
    }
    
    enum LoginButton {        
        enum Insents {
            static let top: CGFloat = 13
            static let right: CGFloat = 51
            static let bottom: CGFloat = 13
            static let left: CGFloat = 51
        }
    }
    
    
}
