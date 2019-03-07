//
//  LoginPresenter.swift
//  TestLoginApp
//
//  Created Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import Foundation

final class LoginPresenter {
    
    weak var view: LoginViewInput!
    var interactor: LoginInteractorInput!
    var router: LoginRouterInput!
    
    init() { }
    
}

// MARK: - LoginViewOutput
extension LoginPresenter: LoginViewOutput {
    
    func viewIsReady() {
        
    }
    
}

// MARK: - LoginInteractorOutput
extension LoginPresenter: LoginInteractorOutput {

}
