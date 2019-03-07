//
//  UIViewController.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public var topDistance : CGFloat{
        get{
            if self.navigationController != nil,
               !self.navigationController!.navigationBar.isTranslucent{
                return 0
            } else {
                let barHeight = self.navigationController?.navigationBar.frame.height ?? 0
                let statusBarHeight = UIApplication.shared.isStatusBarHidden ? CGFloat(0) : UIApplication.shared.statusBarFrame.height
                return barHeight + statusBarHeight
            }
        }
    }
    
}
