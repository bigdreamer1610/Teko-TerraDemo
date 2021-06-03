//
//  MiniAppLauncher.swift
//  MiniApp
//
//  Created by Tung Nguyen on 9/4/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import HestiaIOS
import Hestia
import MiniAppDemoSDK

public class MiniAppLauncher: IOSAppLauncherProtocol {
    required public init() {
        
    }
    
    public func create(launcherData: AppLauncherData, completion: @escaping (UIViewController?) -> ()) {
        dump(launcherData)
        
        var dict: [String : Any] = [:]
        if let data = launcherData.accessToken {
            dict["accessToken"] = data
        }
        if let data = launcherData.refreshToken {
            dict["refreshToken"] = data
        }
        if let data = launcherData.idToken {
            dict["idToken"] = data
        }
        
        let vc = MiniAppSDK.rootViewController(data: dict)
        completion(vc)
    }
    
}


