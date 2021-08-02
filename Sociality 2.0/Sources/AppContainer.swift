//
//  AppContainer.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

final class AppContainer {
    static func makeRootController() -> UINavigationController {
        
        if User.isAuthorized {
            // TODO: add tabbar when user is autorized
            return UINavigationController(rootViewController: RootTBC())
        } else {
            return UINavigationController(rootViewController: LoginVC())
        }
    }
}
