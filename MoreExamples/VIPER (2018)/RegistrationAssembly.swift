//
//  RegistrationAssembly.swift
//  VIPER Demo
//
//  Created Tim on 7/24/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

final class RegistrationAssembly {
    
    let view: RegistrationViewController
    
    private init(view: RegistrationViewController) {
        self.view = view
    }
    
    static func assemble() -> RegistrationAssembly {
        let storyBoard: UIStoryboard = R.storyboard.registration()
        let view = storyBoard.instantiateInitialViewController() as! RegistrationViewController
        
        let presenter = RegistrationPresenter()
        let interactor = RegistrationInteractor()
        let router = RegistrationRouter()
        
        view.output = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.output = presenter
        
        router.view = view
        
        return RegistrationAssembly(view: view)
    }
    
}
