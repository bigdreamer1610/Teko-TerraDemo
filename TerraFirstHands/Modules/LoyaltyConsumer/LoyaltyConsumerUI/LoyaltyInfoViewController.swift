//
//  LoyaltyInfoViewController.swift
//  TerraFirstHands
//
//  Created by Thuy Nguyen on 01/06/2021.
//

import UIKit
import LoyaltyConsumerUI

class LoyaltyInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TerraLoyaltyConsumerUI.getInstance(by: terraApp)?.openMembershipScreen(self)
    }

}
