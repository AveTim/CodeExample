//
//  MainPresenter.swift
//  TestLoginApp
//
//  Created Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import Foundation

final class MainPresenter {
    
    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!
        
}

// MARK: - MainViewOutput
extension MainPresenter: MainViewOutput {
    
    func viewIsReady() {
        
    }
    
    func didTapAuth() {
        router.goToLogin()
    }
    
}

// MARK: - MainInteractorOutput
extension MainPresenter: MainInteractorOutput {

}
