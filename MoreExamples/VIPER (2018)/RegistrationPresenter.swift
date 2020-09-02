//
//  RegistrationPresenter.swift
//  VIPER Demo
//
//  Created Tim on 7/24/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

final class RegistrationPresenter {
    
    weak var view: RegistrationViewInput!
    var interactor: RegistrationInteractorInput!
    var router: RegistrationRouterInput!
    
    init() { }
    
    var registrationModel: User?
}

// MARK: - RegistrationViewOutput
extension RegistrationPresenter: RegistrationViewOutput {
    
    func viewIsReady() {

    }

    func didTapTerms() {
        router.showTerms()
    }

    func didTapPolicy() {
        router.showPolicy()
    }
    
    func handleNextAction(firstName: String?,
                          lastName: String?,
                          email: String?,
                          password: String?,
                          confirmPassword: String?) {
        guard let firstName = firstName,
            !firstName.isEmpty else {
                view.showMessage(R.string.localizable.registrationInputFirstName())
                return
        }
        guard let lastName = lastName,
            !lastName.isEmpty else {
                view.showMessage(R.string.localizable.registrationInputLastName())
                return
        }
        guard let email = email,
            !email.isEmpty else {
                view.showMessage(R.string.localizable.registrationInputEmail())
                return
        }
        guard let password = password,
            !password.isEmpty else {
                view.showMessage(R.string.localizable.registrationInputPassword())
                return
        }
        guard let confirmPassword = confirmPassword,
            !confirmPassword.isEmpty else {
                view.showMessage(R.string.localizable.registrationInputConfirmPassword())
                return
        }
        guard confirmPassword == password else {
            view.showMessage(R.string.localizable.registrationInputCorrentConfirmPassword())
            return
        }
        
        interactor.createUser(email: email,
                              password: password,
                              firstName: firstName,
                              lastName: lastName)
    }
}

// MARK: - RegistrationInteractorOutput
extension RegistrationPresenter: RegistrationInteractorOutput {
    
    func didSuccessfullyRegistration(user: User) {
        router.goNext(model: user)
    }
    
    func didReceivedAnError(_ error: String) {
        view.showMessage(error)
    }
    
}
