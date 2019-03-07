//
//  NetworkService.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import Moya
import UIKit
import Result

protocol NetworkService {
    func loadWeatherFor(query: String,
                        successCallback: @escaping ((WeatherResponse) -> Void),
                        errorCallback: @escaping (String) -> Void)
}

struct NetworkServiceImpl: NetworkService {
    fileprivate let provider = MoyaProvider<ServerAPI>() // (plugins: [NetworkLoggerPlugin(verbose: true)])
    
    enum NetworkResult<T> {
        case success(T)
        case failure(Error)
    }
    
    enum NetworkManager: Error {
        case ParseError
    }
    
    func loadWeatherFor(query: String,
                        successCallback: @escaping ((WeatherResponse) -> Void),
                        errorCallback: @escaping (String) -> Void) {
        provider.request(.weather(query: query)) { response in
            switch response {
            case .success(let result):
                if let baseResult = try? JSONDecoder().decode(WeatherResponse.self, from: result.data) {
                    successCallback(baseResult)
                } else if let errorResult = try? JSONDecoder().decode(ErrorResponse.self, from: result.data),
                          let errorMessage = errorResult.errorMessage {
                    errorCallback(errorMessage)
                } else {
                    errorCallback(LS.Global.error)
                }
            case .failure(let error):
                errorCallback(error.localizedDescription)
            }
        }
    }
    
}
