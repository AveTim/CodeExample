//
//  ServerAPI.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import Moya

enum ServerAPI {
    case weather(query: String)
}

extension ServerAPI: TargetType {
    
    var baseURL: URL {
        return AppConfig.baseURL
    }
    
    var path: String {
        switch self {
        case .weather:
            return "data/2.5/weather"
        }
    }
    
    var method: Method {
        switch self {
        case .weather:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .weather(let query):
            var parameters: [String: Any] = [:]
            parameters["APPID"] = AppConfig.apiKey
            parameters["q"] = query
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .weather:
            return nil
        }
    }
    
}
