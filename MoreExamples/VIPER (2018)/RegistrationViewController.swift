//
//  RegistrationViewController.swift
//  VIPER Demo
//
//  Created Tim on 7/24/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import WebKit

final class RegistrationViewController: UIViewController {
    
    var output: RegistrationViewOutput!
    
    @IBOutlet private weak var firstNameTextField: DesignableTextField!
    @IBOutlet private weak var lastNameTextField: DesignableTextField!
    @IBOutlet private weak var emailTextField: DesignableTextField!
    @IBOutlet private weak var passwordTextField: DesignableTextField!
    @IBOutlet private weak var confirmPasswordTextField: DesignableTextField!
    @IBOutlet private weak var policyAndTermsLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        configureNextButton()
        configurePolicyAndTerms()
        
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false

        setNavigationTranslucent()
        setNavigationColor()
    }

    private func configureTextFields() {
        firstNameTextField.placeholder = R.string.localizable.registrationFirstName()
        lastNameTextField.placeholder = R.string.localizable.registrationLastName()
        emailTextField.placeholder = R.string.localizable.registrationEmail()
        passwordTextField.placeholder = R.string.localizable.registrationPassword()
        confirmPasswordTextField.placeholder = R.string.localizable.registrationConfirmPassword()

        [
            firstNameTextField,
            lastNameTextField,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField
        ].forEach {
            $0.addBorder(side: .bottom,
                         color: .white,
                         width: 1)
        }
    }

    private func configureNextButton() {
        nextButton.setTitle(R.string.localizable.registrationNext(),
                               for: .normal)

        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        nextButton.clipsToBounds = true

        nextButton.backgroundColor = UIColor(red: 212, green: 212, blue: 212, alpha: 1)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        nextButton.clearColorForTitle()
    }

    private func configurePolicyAndTerms() {
        let text = R.string.localizable.registrationPolicyAndTermsTitle()
        let underlineAttriString = NSMutableAttributedString(string: text)

        let rangePolicy = (text as NSString).range(of: R.string.localizable.registrationPolicyTitle())
        underlineAttriString.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: rangePolicy)
        let rangeTerms = (text as NSString).range(of: R.string.localizable.registrationTermsTitle())
        underlineAttriString.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: rangeTerms)
        policyAndTermsLabel.attributedText = underlineAttriString

        policyAndTermsLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
        policyAndTermsLabel.addGestureRecognizer(tap)
    }

    @objc private func dismissController(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func didTapNext(_ sender: UIButton) {
        output.handleNextAction(firstName: firstNameTextField?.text,
                                lastName: lastNameTextField?.text,
                                email: emailTextField?.text,
                                password: passwordTextField?.text,
                                confirmPassword: confirmPasswordTextField?.text)
    }
    
    @IBAction private func tapLabel(gesture: UITapGestureRecognizer) {
        guard let text = policyAndTermsLabel.text else { return }
        let privacyRange = (text as NSString).range(of: R.string.localizable.registrationPolicyTitle())
        let termsRange = (text as NSString).range(of: R.string.localizable.registrationTermsTitle())
        
        if gesture.didTapAttributedTextInLabel(label: policyAndTermsLabel, inRange: privacyRange) {
            output.didTapPolicy()
        } else if gesture.didTapAttributedTextInLabel(label: policyAndTermsLabel,
                                                      inRange: termsRange) {
            output.didTapTerms()
        } else {
            print("Tapped none")
        }
    }

}

// MARK: - RegistrationViewInput
extension RegistrationViewController: RegistrationViewInput {
    
}
