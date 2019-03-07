//
//  ProgressHUD.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

open class ProgressHUD {
    
    internal static var spinnerView: UIActivityIndicatorView?
    
    public static var style: UIActivityIndicatorView.Style = .white
    public static var backgroundColor: UIColor = UIColor(white: 0, alpha: 0.6)
    
    internal static var touchHandler: (() -> Void)?
    
    public static func spin(style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.whiteLarge,
                            backgroundColor: UIColor = backgroundColor,
                            touchHandler: (() -> Void)? = nil) {
        if spinnerView == nil,
           let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            spinnerView = UIActivityIndicatorView(frame: frame)
            spinnerView!.backgroundColor = backgroundColor
            spinnerView!.style = style
            DispatchQueue.main.async {
                window.addSubview(spinnerView!)
                spinnerView!.startAnimating()
            }
        }
        
        if touchHandler != nil {
            self.touchHandler = touchHandler
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(runTouchHandler))
            spinnerView!.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc internal static func runTouchHandler() {
        if touchHandler != nil {
            touchHandler!()
        }
    }
    
    public static func stop() {
        if let _ = spinnerView {
            DispatchQueue.main.async {
                spinnerView!.stopAnimating()
                spinnerView!.removeFromSuperview()
                spinnerView = nil
            }
        }
    }
}
