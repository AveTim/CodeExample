//
//  RegistrationInteractor.swift
//  VIPER Demo
//
//  Created Tim on 7/24/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Firebase

final class RegistrationInteractor {
    
    weak var output: RegistrationInteractorOutput!
    weak var keychainManager: KeychainManager!

    init() {
        
    }
    
}

// MARK: - RegistrationInteractorInput
extension RegistrationInteractor: RegistrationInteractorInput {

    func createUser(email: String,
                    password: String,
                    firstName: String?,
                    lastName: String?) {
        Auth.auth().createUser(withEmail: email,
                               password: password) { [weak self] (authResult, error) in
            if let user = authResult?.user {
                keychainManager.saveUser(id: user.uid,
                                         username: email,
                                         password: password)
                
                let user = User(uid: user.uid, name: firstName, surname: lastName)
                self?.output.didSuccessfullyRegistration(user: user)
            } else if let error = error {
                let errorMessage = ErrorManager.handleError(error) ?? error.localizedDescription
                self?.output.didReceivedAnError(errorMessage)
            }
        }
    }
    
}
