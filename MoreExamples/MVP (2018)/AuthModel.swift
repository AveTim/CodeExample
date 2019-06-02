//
//  AuthModel.swift
//
//  Created Tim on 6/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

protocol AuthModelInput: class {
    func login(_ login: String, password: String,
               success: @escaping () -> Void,
               fail: @escaping (_ error: Error) -> Void)
}

final class AuthModel {
    var introService: IntroService!
}

// MARK: - AuthModelInput
extension AuthModel: AuthModelInput {

    func login(_ login: String,
               password: String,
               success: @escaping () -> Void,
               fail: @escaping (_ error: Error) -> Void) {
        introService.signin(login, password) { result in
            switch result {
            case .success(_):
                success()
            case .failure(let error):
                fail(error)
            }
        }
    }

}
