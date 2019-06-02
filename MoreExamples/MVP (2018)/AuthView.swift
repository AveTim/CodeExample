//
//  AuthView.swift
//
//  Created Tim on 6/7/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

protocol AuthViewInput: class, MessagesProtocol {
    func setupInitialState()
    func setState(_ state: AuthView.State)
    func goToMainScreen()
    func goToRestoreScreen()
    func goToRegisterScreen()
}

protocol AuthViewOutput: class {
    func viewIsReady()
    func handleLoginAction(_ login: String, _ password: String)
    func hanldeRegisterAction()
    func hanldeRecoveryPasswordAction()
    func hanldeEnterWithoutRegisterAction()
    func handleTryAgainAction()
}

final class AuthView: BasicViewController {

    enum State {
        case normal
        case error(_ error: String)
    }

    var output: AuthViewOutput!

    // MARK: Actions
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var recoverPasswordButton: UIButton!
    @IBOutlet private var enterSocialLabel: UILabel!
    @IBOutlet private var registerButton: UIButton!
    @IBOutlet private var enterWithoutRegisterButton: UIButton!
    @IBOutlet private var emailTextField: EmailTextField!
    @IBOutlet private var passwordTextField: PasswordTextField!
    @IBOutlet private var loginButton: GreyBorderButton!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var tryAgain: TryAgainButton!

    // MARK: Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        view.endEditing(true)
    }

    // MARK: UI
    private func setupUI() {
        titleLabel.textColor = .black70
        titleLabel.font = UIFont.textStyle33
        
        messageLabel.textColor = .black70
        messageLabel.font = UIFont.textStyle7
        
        recoverPasswordButton.titleLabel?.font = UIFont.textStyle27
        recoverPasswordButton.setTitleColor(UIColor.black70, for: .normal)
        
        enterSocialLabel.textColor = .black70
        enterSocialLabel.font = UIFont.textStyle34
        
        enterWithoutRegisterButton.setTitleColor(.black70, for: .normal)
        enterWithoutRegisterButton.titleLabel?.font = UIFont.textStyle27
        
        registerButton.setTitleColor(.black70, for: .normal)
        registerButton.tintColor = .black70
        registerButton.titleLabel?.font = UIFont.textStyle27
        
        emailTextField.setPlaceholder(R.string.localizable.welcomeLoginEmail())
        emailTextField.delegate = self
        emailTextField.text = UserDefaultsManager.auth.getEmail()

        passwordTextField.setPlaceHolder(R.string.localizable.welcomeLoginPassword())
        passwordTextField.delegate = self
        
        errorLabel.textColor = .errorRed
        errorLabel.font = R.font.latoRegular(size: 13)
        
        loginButton.isEnabled = false
    }
    
    // MARK: Actions
    @IBAction private func didTapLogin(_ sender: Any) {
        view.endEditing(true)
        output.handleLoginAction(emailTextField.text, passwordTextField.text)
    }
    
    @IBAction private func didTapEnterWithoutRegister(_ sender: Any) {
        view.endEditing(true)
        output.hanldeEnterWithoutRegisterAction()
    }
    
    @IBAction private func didTapRegister(_ sender: Any) {
        view.endEditing(true)
        output.hanldeRegisterAction()
    }
    
    @IBAction private func didTapRecoveryPassword(_ sender: Any) {
        view.endEditing(true)
        output.hanldeRecoveryPasswordAction()
    }
    
    @IBAction private func didTapTryAgain(_ sender: Any) {
        output.handleTryAgainAction()
    }
}

// MARK: - EmailTextFieldDelegate, PasswordTextFieldDelegate
extension AuthView: EmailTextFieldDelegate, PasswordTextFieldDelegate {
    func textFieldDidChange(_ text: String) {
        var validate = true
        
        if emailTextField.text.isEmpty {
            validate = false
        } else if passwordTextField.text.isEmpty {
            validate = false
        }
        
        loginButton.isEnabled = validate
    }
}

// MARK: - AuthViewInput
extension AuthView: AuthViewInput {

    func setupInitialState() {

    }
    
    func setState(_ state: AuthView.State) {
        switch state {
        case .normal:
            emailTextField.isHidden = false
            passwordTextField.isHidden = false
            recoverPasswordButton.isHidden = false
            messageLabel.isHidden = false
            loginButton.isHidden = false
            
            errorLabel.isHidden = true
            tryAgain.isHidden = true
        case .error(let error):
            emailTextField.isHidden = true
            passwordTextField.isHidden = true
            recoverPasswordButton.isHidden = true
            messageLabel.isHidden = true
            loginButton.isHidden = true
            
            errorLabel.isHidden = false
            errorLabel.text = error
            tryAgain.isHidden = false
        }
    }
    
    func goToMainScreen() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = R.storyboard.root().instantiateInitialViewController() as! RootTabBarView
    }
    
    func goToRestoreScreen() {
        let viewController = R.storyboard.recoveryPass().instantiateInitialViewController() as! RecoveryPassView
        self.present(viewController, animated: false, completion: nil)
    }
    
    func goToRegisterScreen() {
        let viewController = R.storyboard.registration().instantiateInitialViewController() as! RegistrationView
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
