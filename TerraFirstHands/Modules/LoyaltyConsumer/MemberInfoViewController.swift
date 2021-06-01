//
//  MemberInfoViewController.swift
//  TerraFirstHands
//
//  Created by Thuy Nguyen on 31/05/2021.
//

import UIKit
import LoyaltyComponent
import LoyaltyConsumer
import LoyaltyConsumerUI
import LoyaltyModel

class MemberInfoViewController: UIViewController {
    
    var cardView = MemberCardView()
    var controller: MemberCardController?

    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 3)
        controller = .init(terraApp: terraApp, view: cardView, memberCard: MemberCard(name: "Thuy Nguyen Duong Thu", avatar: "simpson"), delegate: self)
        controller?.enable()
        controller?.reload()
        view.addSubview(cardView)
    }

}

extension MemberInfoViewController : MemberCardViewDelegate {
    func onSettingTapped() {
        view.makeToast("tap Settings")
    }

    func onRegisterTapped() {
        view.makeToast("tap Register")
    }

    func onUseCardTapped() {
        
    }

    func onMemberCardError(_ error: LoyaltyError) {
        view.makeToast("tap MemberCard")
    }


}
