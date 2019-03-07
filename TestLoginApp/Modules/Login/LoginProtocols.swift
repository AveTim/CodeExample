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
    
}

protocol LoginInteractorOutput: class {
   
}

// MARK: - Router
protocol LoginRouterInput: class {
    
}

// MARK: View Controller
protocol LoginViewInput: class {
    
}

protocol LoginViewOutput: class {
    func viewIsReady()
}
