//
//  MainViewController.swift
//  TestLoginApp
//
//  Created by Tim on 3/6/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    var output: MainViewOutput!

    @IBOutlet private weak var authButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        output.viewIsReady()
    }

    @IBAction private func didTapAuth(_ sender: UIButton) {
        output.didTapAuth()
    }
    
    private func setupUI() {
        navigationItem.title = String.Main.title.localized()
        
        authButton.isExclusiveTouch = true
        authButton.backgroundColor = .tangerine
        authButton.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
        authButton.clipsToBounds = true
        authButton.setTitle(String.Main.AuthButton.title.localized(),
                             for: .normal)
        authButton.titleLabel?.font = .textStyle5
        authButton.tintColor = .customWhite
        authButton.contentEdgeInsets = UIEdgeInsets.init(top: C.AuthButton.Insents.top,
                                                          left: C.AuthButton.Insents.left,
                                                          bottom: C.AuthButton.Insents.bottom,
                                                          right: C.AuthButton.Insents.right)
    }
    
}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    
}

// MARK: - Constraints
private enum C {
    
    enum AuthButton {
        enum Insents {
            static let top: CGFloat = 13
            static let right: CGFloat = 51
            static let bottom: CGFloat = 13
            static let left: CGFloat = 51
        }
    }
    
}
