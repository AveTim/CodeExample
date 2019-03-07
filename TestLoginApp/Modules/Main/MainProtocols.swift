//
//  MainProtocols.swift
//  TestLoginApp
//
//  Created Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: Interactor
protocol MainInteractorInput: class {
    
}

protocol MainInteractorOutput: class {
   
}

// MARK: - Router
protocol MainRouterInput: class {
    func goToLogin()
}

// MARK: View Controller
protocol MainViewInput: class {
    
}

protocol MainViewOutput: class {
    func viewIsReady()
    func didTapAuth()
}
