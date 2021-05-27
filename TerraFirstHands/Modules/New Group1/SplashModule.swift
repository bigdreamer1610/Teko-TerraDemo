//
//  SplashModule.swift
//  TerraFirstHands
//
//  Created by Teko on 26/05/2021.
//

import UIKit

class SplashModule : SplashBuilderProtocol {

    static func show(onViewController viewController: UIViewController, dismissHandler: @escaping () -> Void) {
        let vc = RouterType.splash(dismissHandler: dismissHandler).getVc()
        vc.modalPresentationStyle = .fullScreen
        viewController.present(vc, animated: true, completion: nil)
    }
}
