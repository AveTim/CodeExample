//
//  ErrorResponse.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import Foundation

struct ErrorResponse {
    let code: String?
    let errorMessage: String?
}

extension ErrorResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case errorMessage = "message"
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try? container.decode(String.self, forKey: .code)
        errorMessage = try? container.decode(String.self, forKey: .errorMessage)
    }
}
