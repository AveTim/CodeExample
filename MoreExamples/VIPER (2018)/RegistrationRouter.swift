//
//  RegistrationRouter.swift
//  VIPER Demo
//
//  Created Tim on 7/24/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

final class RegistrationRouter {
    
    weak var view: RegistrationViewController!
    
}

// MARK: - RegistrationRouterInput
extension RegistrationRouter: RegistrationRouterInput {

    func goBack() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func goNext(model: User) {
        let regConfirmView = RegistrationConfirmAssembly.assemble(model: model).view
        
        view.navigationController?.pushViewController(regConfirmView,
                                                      animated: true)
    }

    func showTerms() {
        guard let documentURL = Bundle.main.resourceURL?.appendingPathComponent("terms-ru.pdf") else {
            return
        }
        let urlRequest = URLRequest(url: documentURL)

        let webView = WebView()
        webView.webView.loadRequest(urlRequest)

        let navigationController = UINavigationController(rootViewController: webView)
        webView.navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.close(),
                                                                   style: .plain,
                                                                   target: self,
                                                                   action: #selector(dismissController(sender:)))

        view.present(navigationController, animated: true, completion: nil)
    }

    func showPolicy() {
        guard let documentURL = Bundle.main.resourceURL?.appendingPathComponent("policy-ru.pdf") else {
            return
        }
        let urlRequest = URLRequest(url: documentURL)

        let webView = WebView()
        webView.webView.loadRequest(urlRequest)

        let navigationController = UINavigationController(rootViewController: webView)
        webView.navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.close(),
                                                                   style: .plain,
                                                                   target: self,
                                                                   action: #selector(dismissController(sender:)))

        present(navigationController, animated: true, completion: nil)
    }
}
