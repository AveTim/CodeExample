//
//  AppConfig.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

enum AppConfig {
    static let baseURL = URL(string: "http://api.openweathermap.org")!
    static let apiKey = "e97e869b31e1e5664c31f3319137d27f"
    
    static func clearNavigationBackButton() {
        // clear back button
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 0.1),
                          NSAttributedString.Key.foregroundColor: UIColor.clear]
        
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes,
                                                            for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes,
                                                            for: UIControl.State.highlighted)
    }
    
    static func setupNavigationColor() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .darkSkyBlueTwo
        UINavigationBar.appearance().titleTextAttributes = [ .font: UIFont.textStyle7 ]
    }
    
}
