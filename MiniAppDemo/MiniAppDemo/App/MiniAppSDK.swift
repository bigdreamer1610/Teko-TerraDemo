//
//  MiniAppSdk.swift
//  MiniApp
//
//  Created by Tung Nguyen on 9/4/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

public class MiniAppSDK {
    
    public static func rootViewController(data: [String : Any]) -> UIViewController {
        let root = Application.shared.getRootViewControllerForSdk(data: data)
        
        SVProgressHUD.setDefaultMaskType(.clear)
        
        return root
    }
    
}
