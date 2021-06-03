//
//  Application.swift
//  MiniApp
//
//  Created by linhvt on 11/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import UIKit
import TerraInstancesManager

class Application {
    static var shared = Application()
    
    var window: UIWindow!
    var application: UIApplication!
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    var sdkLaunchOptions: [String: Any]?
    var loginCompletion: ((Bool) -> Void)?
    
    func attachWindow(_ window: UIWindow) {
        self.window = window
        self.window.backgroundColor = .black
    }
    
    func buildRootViewController() {
        let vc = MainViewController(nibName: "MainViewController", bundle: Bundle(for: MainViewController.self))
        let nav = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    
    func getRootViewControllerForSdk(data: [String : Any]) -> UIViewController {
        let vc = MainViewController(nibName: "MainViewController", bundle: Bundle(for: MainViewController.self))
        sdkLaunchOptions = data
        return vc
    }

    func appDidFinishLaunchingWithOptions(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.application = application
        self.launchOptions = launchOptions
        buildRootViewController()
    }


}
