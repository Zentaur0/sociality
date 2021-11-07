//
//  AuthorizationManager.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 07.11.2021.
//

import UIKit

// MARK: - AuthorizationAdapter

protocol AuthorizationAdapter {
    func authorize(sender: UIViewController, isAuthorized: Bool)
}

// MARK: - AuthorizationManager

final class AuthorizationManager: AuthorizationAdapter {
    
    func authorize(sender: UIViewController, isAuthorized: Bool) {
        if isAuthorized {
            UserDefaults.standard.set(true, forKey: "isAuthorized")
            
            DispatchQueue.main.async {
                sender.dismiss(animated: true) {
                    AppContainer.createSpinnerView(UIApplication.topViewController() ?? UIViewController(),
                                                   AppContainer.makeRootController())
                }
            }
        } else {
            UserDefaults.standard.set(false, forKey: "isAuthorized")

            DispatchQueue.main.async {
                sender.dismiss(animated: true) {
                    AppContainer.createSpinnerView(UIApplication.topViewController() ?? UIViewController(),
                                                   AppContainer.makeRootController())
                }
            }
        }
    }
    
}
