//
//  SplashViewController.swift
//  TerraFirstHands
//
//  Created by Thuy Nguyen on 27/05/2021.
//

import UIKit

class SplashViewController: BaseViewController {
    
    var presenter: SplashPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.initData()

        // Do any additional setup after loading the view.
    }
}

extension SplashViewController : SplashViewProtocol {
    func showMessage(_ message: String) {
        AlertUtils.showAlert(from: self, with: "Alert", message: "Something is wrong")
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
