//
//  FirstViewController.swift
//  TerraFirstHands
//
//  Created by Teko on 25/05/2021.
//

import UIKit
import Terra
import TerraInstancesManager
import Janus
import JanusGoogle

class FirstViewController: UIViewController {

    let terraApp: ITerraApp? = (UIApplication.shared.delegate as? AppDelegate)?.terraApp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TerraAuth.getInstance(by: terraApp!)?.registerGoogle()
    }
    
    func loginGoogle() {
        
    }

    @IBAction func clickLogin(_ sender: Any) {
        TerraAuth.getInstance(by: terraApp!)?.loginWithGoogle(presentViewController: self, delegate: self)
    }
    
}

extension FirstViewController : JanusLoginDelegate {
    func janusHasLoginSuccess(authCredential: JanusAuthCredential) {
        print("success")
    }
    
    func janusHasLoginFail(error: JanusError?) {
        print("fail")
    }
    
}
