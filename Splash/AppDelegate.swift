//
//  AppDelegate.swift
//  Splash
//
//  Created by Ashwin Somkuwar on 28/04/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let launchScreenViewController = "LaunchScreen"
    let rootViewController = "SplashController"
    let main = "Main"
    let mainViewController = "ViewController"
    let timer = 5.0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        showSplashScreen()
        return true
    }
    
    // Function to show the Launch Screen
    private func showSplashScreen() {
        let launchScreenVC = UIStoryboard.init(name: launchScreenViewController, bundle: nil)
        let rootVC = launchScreenVC.instantiateViewController(withIdentifier: rootViewController)
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        
        // Timer of 5 seconds
        Timer.scheduledTimer(timeInterval: timer, target: self, selector: #selector(dismissSplashController), userInfo: nil, repeats: false)
    }
    
    @objc func dismissSplashController() {
        let mainVC = UIStoryboard.init(name: main, bundle: nil)
        let rootVC = mainVC.instantiateViewController(withIdentifier: mainViewController)
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

