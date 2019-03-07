//
//  LoginInteractor.swift
//  TestLoginApp
//
//  Created Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import Foundation

final class LoginInteractor {
    
    weak var output: LoginInteractorOutput!

    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
}

// MARK: - LoginInteractorInput
extension LoginInteractor: LoginInteractorInput {

    func loadWeather(query: String) {
        networkService.loadWeatherFor(query: query,
                               successCallback: { [weak self] (weatherResponse) in
                                self?.output.didLoadWeather(weatherResponse)
            }, errorCallback: { [weak self] (error) in
                self?.output.didReceivedAnError(error)
        })
    }
    
}
