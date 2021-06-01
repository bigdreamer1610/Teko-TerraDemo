//
//  VerifyPhonenumberViewController.swift
//  TerraFirstHands
//
//  Created by Thuy Nguyen on 31/05/2021.
//

import UIKit
import TekUserService
import TekIdentityService

class VerifyPhonenumberViewController: UIViewController {

    @IBOutlet weak var tfPhonenumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickVerify(_ sender: Any) {
        guard let phoneNumber = tfPhonenumber.text else {
            return
        }
        TerraIdentity.getInstance(by: terraApp)?.update(.phone(value: "0345116457"), otp: phoneNumber, completion: { (type, isSuccess, num) in
            if isSuccess {
                print("verify successfully")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Update failed")
            }
        })
    }
    
}
