//
//  AppDelegate.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 30.07.2021.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Static
    
    static let shared = UIApplication.shared.delegate as! AppDelegate

    // MARK: Properties
    
    var window: UIWindow?
    private let notificationCenter = UNUserNotificationCenter.current()

    // MARK: - Methods
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = AppContainer.makeRootController()
        
//        setupNotification()
//        sendNotification()
        
        return true
    }
    
    private func setupNotification() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { isGranted, error in
            
            guard isGranted else { return }
            
            self.notificationCenter.getNotificationSettings { settings in
                print(settings)
                
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
        
        notificationCenter.delegate = self
    }
    
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "First notification"
        content.body = "My first notification"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "self.notification.custom", content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            print(error?.localizedDescription)
        }
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

// MARK: - UNUserNotificationCenterDelegate
/// this delegate needs in order to setup notification when app is in foreground mode

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
        print(#function)
    }
    
    /// this method can setup user tap on notification when app in background mode and notification is shown
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
    
}
