//
//  LoginProtocols.swift
//  TestLoginApp
//
//  Created Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: Interactor
protocol LoginInteractorInput: class {
    func loadWeather(query: String)
}

protocol LoginInteractorOutput: class {
    func didLoadWeather(_ weatherResponse: WeatherResponse)
    func didReceivedAnError(_ error: String)
}

// MARK: - Router
protocol LoginRouterInput: class {
    
}

// MARK: View Controller
protocol LoginViewInput: class, MessageHelper {
    
}

protocol LoginViewOutput: class {
    func viewIsReady()
    func didTapForgotPassword()
    func didTapLogin(email: String?, password: String?)
    func didTapRegistration()
}
