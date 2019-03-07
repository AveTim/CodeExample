//
//  LocalizationConstants.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import Foundation

struct LS {
    
    // MARK: - Global
    struct Global {
        static let ok = "Global.ok"
        static let space = "Global.space"
        static let error = "Global.error"
    }
    
    // MARK: - Main
    struct Main {
        struct AuthButton {
            static let title = "Main.AuthButton.title"
        }
    }
    
    // MARK: - Auth
    struct Auth {
        static let title = "Auth.title"
        
        struct EnterEmail {
            static let title = "Auth.EnterEmail.title"
            static let placeholder = "Auth.EnterEmail.placeholder"
        }
        
        struct EnterPassword {
            static let title = "Auth.EnterPassword.title"
            static let placeholder = "Auth.EnterPassword.placeholder"
        }
        
        struct ForgotPasswordButton {
            static let title = "Auth.ForgotPasswordButton.title"
        }
        
        struct LoginButton {
            static let title = "Auth.LoginButton.title"
        }
        
        struct RegistrationButton {
            static let title = "Auth.RegistrationButton.title"
        }
   
        struct Error {
            static let incorrectEmail = "Auth.Error.Email.incorrect"
            
            struct Password {
                static let incorrect = "Auth.Error.Password.incorrect"
                static let toShort = "Auth.Error.Password.toShort"
                static let oneUppercase = "Auth.Error.Password.oneUppercase"
                static let oneLowercase = "Auth.Error.Password.oneLowercase"
                static let oneDigit = "Auth.Error.Password.oneDigit"
            }
        
        }
    }
    
}
