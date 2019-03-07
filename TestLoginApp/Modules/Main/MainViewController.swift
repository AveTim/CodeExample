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
        
        output.viewIsReady()
    }

    @IBAction private func didTapAuth(_ sender: UIButton) {
        let loginVC = LoginAssembly.assemble().view
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    
}

