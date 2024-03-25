//
//  AppDelegate.swift
//  Pickers
//
//  Created by Sedat on 24.03.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let profileVC = ProfileViewController()
        let navigationController = UINavigationController(rootViewController: profileVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
