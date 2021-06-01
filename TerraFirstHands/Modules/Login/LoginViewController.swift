//
//  LoginViewController.swift
//  TerraFirstHands
//
//  Created by Teko on 26/05/2021.
//

import UIKit
import Janus
import JanusGoogle
import JanusFacebook
import JanusApple

class LoginViewController: UIViewController {
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    
    func setUp() {
        SplashModule.show(onViewController: self) {[weak self] in
            print("Terra App is loaded successfully")
        }
        
        if let _ = UserDefaults.standard.string(forKey: "token") {
            next()
        }
    }
    
    func next() {
        let vc = RouterType.pay.getVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func clickLogin(_ sender: Any) {
        TerraAuth.getInstance(by: terraApp)?.loginWithGoogle(presentViewController: self, delegate: self)
    }
    
    @IBAction func clickLoginFacebook(_ sender: Any) {
        TerraAuth.getInstance(by: terraApp)?.loginWithFacebook(presentViewController: self, delegate: self)
    }
    
    
    @IBAction func clickLoginPhone(_ sender: Any) {
        
    }
    
}

extension LoginViewController : JanusLoginDelegate {
    func janusHasLoginSuccess(authCredential: JanusAuthCredential) {
        defaults.setValue(authCredential.accessToken, forKey: "token")
        next()
    }
    
    func janusHasLoginFail(error: JanusError?) {
        print("fail: \(error?.localizedDescription)")
    }
}
