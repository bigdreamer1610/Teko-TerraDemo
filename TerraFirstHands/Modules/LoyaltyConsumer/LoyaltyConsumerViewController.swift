//
//  LoyaltyConsumerViewController.swift
//  TerraFirstHands
//
//  Created by Thuy Nguyen on 31/05/2021.
//

import UIKit
import LoyaltyCore
import LoyaltyModel
import LoyaltyComponent
import LoyaltyConsumer
import LoyaltyConsumerUI
import TekoTracker

class LoyaltyConsumerViewController: UIViewController {
    
    var redeemView = LoyaltyRedeemPointView()
    var componentController: LoyaltyRedeemPointController?
    
    var memberInfo: MemberResult?
    var networkConfig: NetworkConfigResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        
        redeemView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 70)
        redeemView.isUserInteractionEnabled = true
        componentController = LoyaltyRedeemPointController(terraApp: terraApp, orderAmount: 100, points: 5000, delegate: self)
        redeemView.setController(componentController!)
        componentController?.reload()
        componentController!.enable()
        
        redeemView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(openPopUp)))
        
        view.addSubview(redeemView)
        
    }
    
    func getTransaction() {
        let param = HistoryRequestParams(txnTypes: [.SPEND, .GRANT], merchantCode: "vnshop", fromTime: "2021-05-01 17:00:00", toTime: "2021-05-30 17:00:00", status: 1, page: 0, size: 2)
        TerraLoyalty.getInstance(by: terraApp)?.getHistory(params: param, completion: { (result) in
            switch result {
            case .failure(let error):
                print("fail: \(String(describing: error))")
            case .success(let response):
                print("success: \(String(describing: response.result?.transactions))")
                
            }
        })
    }
    
    func initData() {
        TerraLoyalty.getInstance(by: terraApp)?.getMemberInfo(completion: {[weak self] (result) in
            guard let `self` = self else {return}
            switch result {
            case .success(let response):
                self.memberInfo = response.result
            case .failure(let error):
                print(String(describing: error))
            }
        })
        
        TerraLoyalty.getInstance(by: terraApp)?.getNetworkConfig(completion: { [weak self](result) in
            guard let `self` = self else {return}
            switch result {
            case .success(let response):
                self.networkConfig = response.result
            case .failure(let error):
                print(String(describing: error))
                
            }
        })
    }
    
    @objc func openPopUp() {
        
        print("click popup")
        let popup = LoyaltyRedeemPointPopupModule.build(terraApp: terraApp, orderAmount: 100, memberResult: self.memberInfo!, config: self.networkConfig!, delegate: self)
                present(popup, animated: false, completion: nil)
    }
    
    @IBAction func clickOpenPopup(_ sender: Any) {
        openPopUp()
    }
    
    
    @IBAction func openMemberCard(_ sender: Any) {
        let vc = RouterType.memberCard.getVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openConsumerUI(_ sender: Any) {
        TerraLoyaltyConsumerUI.getInstance(by: terraApp)?.openMembershipScreen(self)
    }
    
    
    
}

extension LoyaltyConsumerViewController : LoyaltyRedeemPointDelegate {
    func onRedeemPointError(_ error: RedeemPointError) {
        print("on error:")
        view.makeToast(String(describing: error))
    }
    
    func onRedeemPointChange(data: RedeemPointData?) {
        view.makeToast("Redeem point = \(String(describing: data?.points ?? 0))")
    }
    
    func onReady() {
        print("I'm ready")
    }
}

extension LoyaltyConsumerViewController : RedeemPointPopupDelegate {
    func onError(error: LoyaltyError) {
        view.makeToast(String(describing: error))
    }
    
    func onUsePoints(data: RedeemPointData) {
        print("on using points kaka")
    }
    
    func onMemberInfoUpdate(memberResult: MemberResult) {
        print("just clicked update member info")
    }
    
    func onClosePointPopup(redeemSuccess: Bool) {
        print("popup is closed now")
    }
    
    
}
