//
//  AppRouter.swift
//  TerraFirstHands
//
//  Created by Teko on 25/05/2021.
//

import Foundation
import UIKit

enum RouterType {
    case splash(dismissHandler: () -> Void)
    case login
    case welcome
}

extension RouterType {
    func getVc() -> UIViewController {
        switch self {
        case .login:
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
                return UIViewController()
            }
            return vc
        case .splash(let dismissHandler):
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController else {
                return UIViewController()
            }
            let presenter = SplashPresenter(view: vc, dismissHandler: dismissHandler)
            vc.presenter = presenter
            return vc
        case .welcome:
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController else {
                return UIViewController()
            }
            return vc
        }
    }
}
