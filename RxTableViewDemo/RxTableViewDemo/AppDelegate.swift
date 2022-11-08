//
//  AppDelegate.swift
//  RxTableViewDemo
//
//  Created by guoguo on 2022/11/8.
//

import UIKit

let screen_width = UIScreen.main.bounds.width
let screen_height = UIScreen.main.bounds.height

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window:UIWindow? = UIWindow(frame: CGRect(origin: .zero, size: CGSize(width: screen_width, height: screen_height)))

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let vc = DemoVC()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle



}

