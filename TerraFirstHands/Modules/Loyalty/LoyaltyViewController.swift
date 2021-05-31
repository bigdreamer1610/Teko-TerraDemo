//
//  LoyaltyViewController.swift
//  TerraFirstHands
//
//  Created by Thuy Nguyen on 28/05/2021.
//

import UIKit
import LoyaltyCore
import Terra

class LoyaltyViewController: UIViewController {
    
    var loyaltyServce = TerraLoyalty.getInstance(by: terraApp)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickRegisterNewMember(_ sender: Any) {
        let param = RegisterRequestParam(name: "Thuy Nguyen", email: "thuy.ndt@teko.vn", dateOfBirth: "2000", gender: .female, idCardNumber: "123456789", idCitizenNumber: "123456789", passportNumber: "12343544")

        
        loyaltyServce?.register(param: param, completion: { [weak self](result) in
            switch result {
            case .success(let response):
                // Do something with response
                print("register success")
                print(response.result?.member?.name)
            case .failure(let error):
                print("register failed")
                print(String(describing: error))
            }
        })
    }
    

}
