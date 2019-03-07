//
//  MainAssembly.swift
//  TestLoginApp
//
//  Created Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

final class MainAssembly {
    
    let view: MainViewController
    
    private init(view: MainViewController) {
        self.view = view
    }
    
    static func assemble() -> MainAssembly {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyBoard.instantiateInitialViewController() as! MainViewController
        
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        let router = MainRouter()
        
        view.output = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.output = presenter
        
        router.view = view
        
        return MainAssembly(view: view)
    }
    
}
