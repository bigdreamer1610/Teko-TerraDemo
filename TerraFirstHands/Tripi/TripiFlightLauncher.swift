//
//  TripiFlightLauncher.swift
//  SuperAppDemo
//
//  Created by Tung Nguyen on 3/8/21.
//

import Foundation
import HestiaIOS
import Hestia
import UIKit
import TripiFlightPaymentKit
import MAPaymentKit

public class TripiFlightLauncher: IOSAppLauncherProtocol {
    
    public required init() {}
    
    public func create(launcherData: AppLauncherData, completion: @escaping (UIViewController?) -> ()) {
        var config = launcherData.extraConfig
        config["accessToken"] = launcherData.idToken
        print("[TripiFlightConfig]: ", config)
        
        TripiFlightPaymentSDK.shared.callFlightSDK(params: config, delegate: self) { (error, viewController) in
            completion(viewController)
        }
//        let params = ["caid": "20", "accessToken": launcherData.idToken!, "appToken": "zAEM8khXU8TMwAeTPGcidFx3eS7FpXKo", "backButtonIconName": "back", "isHideBottomBar": false, "lang": "vi", "provider": "teko", "buttonRadius": "4"] as [String : Any]
//
//        completion(BackgroundVC(config: params))
    }
    
}

extension TripiFlightLauncher: TripiFlightPaymentSDKDelegate {
    
    public func didBackFromSDK() {
        
    }
    
    public func didBookOrderWith(jsonData: Data?) {
        
    }
    
    
}
