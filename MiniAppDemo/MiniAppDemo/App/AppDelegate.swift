//
//  AppDelegate.swift
//  MiniAppDemo
//
//  Created by linhvt on 3/2/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        Application.shared.attachWindow(window!)
        Application.shared.appDidFinishLaunchingWithOptions(application, didFinishLaunchingWithOptions: launchOptions)

        
        return true
    }


}

