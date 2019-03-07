//
//  MainViewController.swift
//  TestLoginApp
//
//  Created by Tim on 3/6/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private weak var authButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction private func didTapAuth(_ sender: UIButton) {
        let loginVC = UIStoryboard(name: "Login",
                                   bundle: nil).instantiateInitialViewController() as! LoginViewController
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
}

