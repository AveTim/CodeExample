//
//  MessageHelper.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

protocol MessageHelper {
    func showMessage(_ message: String)
}

extension MessageHelper {
    
    func showMessage(_ message: String) {
        (self as? UIViewController)?.showAlert(message: message)
    }
    
}
