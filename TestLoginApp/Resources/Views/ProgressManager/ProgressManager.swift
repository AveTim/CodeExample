//
//  ProgressManager.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

class ProgressManager {
    /// используется для обращения к конкретно этому прогрессу
    static private weak var progress: ProgressHUD!
    static var counter: Int = 0

    static func show() {
        if counter == 0 {
            ProgressHUD.spin()
        }
        
        counter += 1
    }

    static func hide() {
        counter -= 1
        if counter < 0 { counter = 0 }
        if counter == 0 {
            ProgressHUD.stop()
        }
    }
    
    static func forceStop() {
        counter = 0
        ProgressHUD.stop()
    }
}
