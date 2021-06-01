//
//  App.swift
//  TerraFirstHands
//
//  Created by Teko on 26/05/2021.
//

import UIKit
import Terra
import Janus
import JanusGoogle
import LoyaltyCore
import LoyaltyModel
import ApolloTheme

public var terraApp: ITerraApp = TerraInstanceCenter.shared.terraApp

class TerraInstanceCenter {
    public static let shared = TerraInstanceCenter()
    
    var tempTerraApp: ITerraApp?
    
    var terraApp: ITerraApp! {
        return tempTerraApp!
    }
    
    var memberInfo: MemberInfo!
    
    var isTerraLoaded: Bool {
        return tempTerraApp != nil
    }
    
    func loadTerra(completion: @escaping (Bool) -> Void) {
        TerraApp.configure(appName: "vnsmix", bundleId: "vn.teko.ios.vnsmix") {
            (isSuccess, terraApp) in
            guard isSuccess else {
                completion(false)
                return
            }
            TerraInstanceCenter.shared.tempTerraApp = terraApp
            TerraTheme.configureWith(app: terraApp)
            TerraAuth.auth(app: terraApp).registerGoogle()
            print("bus id: \(terraApp.bus.id)")
            completion(isSuccess)
         }
    }
}
