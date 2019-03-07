//
//  WeatherResponse.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import Foundation

struct WeatherResponse {
    let name: String
    let weather: Weather?
}

extension WeatherResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case weather
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        let weatherArray = try? container.decode([Weather].self, forKey: .weather)
        weather = weatherArray?.first
    }
}
