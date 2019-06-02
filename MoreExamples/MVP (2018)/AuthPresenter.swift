//
//  AuthPresenter.swift
//
//  Created Tim on 6/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

final class AuthPresenter {
    
    private weak var view: AuthViewInput!
    private var model: AuthModelInput!

    init(view: AuthViewInput, model: AuthModelInput) {
        self.view = view
        self.model = model
    }
}

// MARK: - TemplateViewOutput
extension AuthPresenter: AuthViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
        view.setState(.normal)
    }
    
    func handleLoginAction(_ login: String, _ password: String) {
        ProgressManager.show()
        model.login(login, password: password, success: { [weak self] in
            ProgressManager.hide()
            self?.view?.goToMainScreen()

        }) { [weak self] error in
            ProgressManager.hide()

            let message: String
            if let responseError = error as? ResponseError,
               let title = responseError.title {
                message = title
            } else {
                message = error.localizedDescription
            }
            self?.view.showMessage(message)
            self?.view.setState(.error(R.string.localizable.welcomeLoginIncorrect()))
        }
    }

    func handleTryAgainAction() {
        view.setState(.normal)
    }
    
    func hanldeRecoveryPasswordAction() {
        view?.goToRestoreScreen()
    }

    func hanldeRegisterAction() {
        view?.goToRegisterScreen()
        AnalyticManager.shared.log(.login_didTapRegister)
    }
    
    func hanldeEnterWithoutRegisterAction() {
        view?.goToMainScreen()
        AnalyticManager.shared.log(.login_didTapWithoutRegister)
    }
}
