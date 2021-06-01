//
//  LoyaltyViewController.swift
//  TerraFirstHands
//
//  Created by Thuy Nguyen on 28/05/2021.
//

import UIKit
import LoyaltyCore
import Terra
import Janus
import TekIdentityService
import TekUserService
import Janus

class LoyaltyViewController: UIViewController {
    
    var loyaltyServce = TerraLoyalty.getInstance(by: terraApp)
    
    let param = RegisterRequestParam(name: "Thuy Nguyen", email: "thuy.ndt@teko.vn")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func clickRedeem(_ sender: Any) {
        let vc = RouterType.loyaltyConsumer.getVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickRegisterMemberToLoyalty(_ sender: Any) {
        TerraLoyalty.getInstance(by: terraApp)?.register(param: param, completion: {[weak self] (result) in
            switch result {
            case .success(let _):
                print("register to loyalty success")
            case .failure(let error):
                print("register to loyalty failed")
                print(String(describing: error))
            }
        })
    }
    
    @IBAction func clickGetMember(_ sender: Any) {        print("start geting member info")
        TerraLoyalty.getInstance(by: terraApp)?.getMemberInfo { [weak self] result in
            switch result {
            case .success(let response):
                print("success getting member: ")
                TerraInstanceCenter.shared.memberInfo = response.result!.member
            case .failure(let error):
                print("error getting member: ")
                print(String(describing: error))
            }
        }
    }
    
    @IBAction func clickRegisterNewMember(_ sender: Any) {
        TerraUser.getInstance(by: terraApp)?.getUserInfo(completion: { (user) in
            if let _ = user {
                print("get user successfully")
                TerraIdentity.getInstance(by: terraApp)?.verify(.phone(value: "0345116457"), completion: { (type, isSuccess, num) in
                    if isSuccess {
                        let vc = RouterType.phoneVerify.getVc()
                        //                        self.navigationController.p
                        self.present(vc, animated: true, completion: nil)
                        
                    } else {
                        print("unable to verify phonenumber")
                    }
                })
            } else {
                print("unable to get user")
            }
        })
    }
    
    @IBAction func clickLogout(_ sender: Any) {
        TerraAuth.getInstance(by: terraApp)?.logout()
        UserDefaults.standard.removeObject(forKey: "token")
        let vc = RouterType.login.getVc()
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        UIApplication.shared.keyWindow?.rootViewController = nav
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        
    }
    
    
    
}
