//
//  RegistrationProtocols.swift
//  VIPER Demo
//
//  Created Tim on 7/24/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

// MARK: Interactor
protocol RegistrationInteractorInput: class {
    func createUser(email: String,
                    password: String,
                    firstName: String?,
                    lastName: String?)
}

protocol RegistrationInteractorOutput: class {
    func didReceivedAnError(_ error: String)
    func didSuccessfullyRegistration(user: User)
}

// MARK: - Router
protocol RegistrationRouterInput: class {
    func goBack()
    func goNext(model: User)
    func showPolicy()
    func showTerms()
}

// MARK: View Controller
protocol RegistrationViewInput: class, MessagesProtocol {
    
}

protocol RegistrationViewOutput: class {
    func viewIsReady()
    func didTapTerms()
    func didTapPolicy()
    func handleNextAction(firstName: String?,
                          lastName: String?,
                          email: String?,
                          password: String?,
                          confirmPassword: String?)
}
