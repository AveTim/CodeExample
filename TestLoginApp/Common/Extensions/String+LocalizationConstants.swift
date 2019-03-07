//
//  String+LocalizationConstants.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Global
    enum Global {
        static let ok = "Global.ok"
        static let space = "Global.space"
        static let error = "Global.error"
    }
    
    // MARK: - Main
    enum Main {
        static let title = "Main.title"
        
        enum AuthButton {
            static let title = "Main.AuthButton.title"
        }
    }
    
    // MARK: - Auth
    enum Auth {
        static let title = "Auth.title"
        
        enum EnterEmail {
            static let title = "Auth.EnterEmail.title"
            static let placeholder = "Auth.EnterEmail.placeholder"
        }
        
        enum EnterPassword {
            static let title = "Auth.EnterPassword.title"
            static let placeholder = "Auth.EnterPassword.placeholder"
        }
        
        enum ForgotPasswordButton {
            static let title = "Auth.ForgotPasswordButton.title"
        }
        
        enum LoginButton {
            static let title = "Auth.LoginButton.title"
        }
        
        enum RegistrationButton {
            static let title = "Auth.RegistrationButton.title"
        }
        
        enum Error {
            static let incorrectEmail = "Auth.Error.Email.incorrect"
            
            enum Password {
                static let incorrect = "Auth.Error.Password.incorrect"
                static let toShort = "Auth.Error.Password.toShort"
                static let oneUppercase = "Auth.Error.Password.oneUppercase"
                static let oneLowercase = "Auth.Error.Password.oneLowercase"
                static let oneDigit = "Auth.Error.Password.oneDigit"
            }
            
        }
    }
}
