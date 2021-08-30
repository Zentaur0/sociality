//
//  AppDelegate.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 30.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let shared = UIApplication.shared.delegate as! AppDelegate

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = AppContainer.makeRootController()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print(#function)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
    }
    
}

