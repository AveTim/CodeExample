//
//  LoginAssembly.swift
//  TestLoginApp
//
//  Created Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

final class LoginAssembly {
    
    let view: LoginViewController
    
    private init(view: LoginViewController) {
        self.view = view
    }
    
    static func assemble() -> LoginAssembly {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let view = storyBoard.instantiateInitialViewController() as! LoginViewController
        
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        
        view.output = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.output = presenter
        
        router.view = view
        
        return LoginAssembly(view: view)
    }
    
}
