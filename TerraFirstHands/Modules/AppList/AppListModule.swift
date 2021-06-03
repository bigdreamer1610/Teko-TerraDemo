//
//  AppListModule.swift
//  TerraFirstHands
//
//  Created by Thuy Nguyen on 02/06/2021.
//

import Foundation
import UIKit

class AppListModule: AppListBuilderProtocol {

    static func build() -> UIViewController {
        let view = AppListViewController(nibName: "AppListViewController", bundle: Bundle(for: AppListViewController.self))
        let presenter = AppListPresenter(view: view)
        
        view.presenter = presenter
        
        return view
    }
}

