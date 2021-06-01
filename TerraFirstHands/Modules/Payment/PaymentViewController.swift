//
//  PaymentViewController.swift
//  TerraFirstHands
//
//  Created by Thuy Nguyen on 28/05/2021.
//

import UIKit
import MinervaUI
import Minerva
import DropDown
import TekoTracker

class PaymentViewController: PaymentBaseViewController {

    @IBOutlet weak var btnPaymentMethod: UIButton!
    @IBOutlet weak var tfPaymenyMethod: UITextField!
    @IBOutlet weak var switchShowResult: UISwitch!
    @IBOutlet weak var tfOrderCode: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tfLoyalty: UITextField!
    @IBOutlet weak var tfPhonenumber: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var tfPartnerID: UITextField!
    
    //variables
    lazy var methods: [PaymentMethod] = PaymentMethod.allCases
    //var trackerMethod: TekoTracker.PaymentMethod = .
    
    var selectedMethod: PaymentMethod = .none {
        didSet {
            self.tfPaymenyMethod.text = selectedMethod.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        initData()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func initComponent() {
        btnPay.layer.cornerRadius = 6
    }
    
    fileprivate func initData() {
        tfOrderCode.text = "order-123"
        tfAmount.text = "100000"
        selectedMethod = .none
        tfName.text = "Nguyen Luong Thien"
        tfPhonenumber.text = "0987654321"
        tfEmail.text = "thuy.ndt@teko.vn"
        tfPartnerID.text = "0987654321"
    }
    
    @IBAction func clickChoosePayment(_ sender: Any) {
        let dropDown = DropDown(frame: CGRect(x: 0, y: 0, width: btnPaymentMethod.frame.width, height: 400))
        dropDown.anchorView = btnPaymentMethod
        dropDown.dataSource = methods.map { $0.title }
        dropDown.bottomOffset = CGPoint(x: 0, y: btnPaymentMethod.frame.size.height)
        dropDown.animationEntranceOptions = .transitionCurlDown
        dropDown.animationExitOptions = .transitionCurlUp
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let `self` = self else { return }
            self.tfPaymenyMethod.text = item
            self.selectedMethod = self.methods[index]
        }
    }
    
    func processPaymentWithLoyaltyOnly() {
        guard selectedMethod == .loyalty else { return }
        guard let orderCode = tfOrderCode.text,
              let loyaltyAmount = Int(tfLoyalty.text ?? ""),
              loyaltyAmount > 0 else {
            return
        }
        
        let order = PaymentOrder(orderCode: orderCode, amount: Double(loyaltyAmount))
        let request = PaymentUIRequestBuilder(order: order,
                                              client: .init())
            .setLoyaltyMethod(points: loyaltyAmount, amount: Double(loyaltyAmount))
            .setUIConfig(.init(shouldShowPaymentResult: switchShowResult.isOn))
            .build()
        
        do {
            try TerraPaymentUI.getInstance(by: terraApp)?.payWith(request: request, delegate: self)
        } catch {
            print(error)
        }
        
    }
    
    func processPaymentFtLoyalty() {
        guard let orderCode = tfOrderCode.text,
              let amount = Double(tfAmount.text ?? "") else {
            return
        }
        
        var onlineAmount = amount
        let loyalTyAmount = Int(tfLoyalty.text ?? "")
        
        if let loyaltyAmount = loyalTyAmount,
           loyaltyAmount > 0,
           selectedMethod != .loyalty {
            onlineAmount = onlineAmount - Double(loyaltyAmount)
        }
        
        let order = PaymentOrder(orderCode: orderCode, amount: amount)
        //                userId: "2c59afde1f11489b8d5bd2cd2674cf83",
        let paymentBuilder = PaymentUIRequestBuilder(order: order, client: .init())
            .setUIConfig(.init(shouldShowPaymentResult: switchShowResult.isOn))
        
        switch selectedMethod {
        case .qrGateway:
            let _ = paymentBuilder.setMainMethod(.vnPayQRGateway(amount: onlineAmount))
        case .mobileBanking:
            let _ = paymentBuilder.setMainMethod(.mobileBanking(amount: onlineAmount))
        case .qrMMS:
            let _ = paymentBuilder.setMainMethod(.vnPayQRMMS(amount: onlineAmount))
        case .qrReversal:
            let _ = paymentBuilder.setMainMethod(.vnPayQRReversal(amount: onlineAmount))
        case .ewallet:
            let _ = paymentBuilder.setMainMethod(.vnPayEWallet(
                                                    amount: onlineAmount,
                                                    customer: VNPayEWalletCustomer(
                                                        partnerId: tfPartnerID.text ?? "",
                                                        phone: tfPhonenumber.text ?? "",
                                                        name: tfName.text,
                                                        email: tfEmail.text)))
        case .momoGateway:
            let _ = paymentBuilder.setMainMethod(.momoGateway(amount: onlineAmount))
        case .atm:
            let _ = paymentBuilder.setMainMethod(.vnPayATMGateway(amount: onlineAmount, route: .banksList))
        case .internationalCard:
            let _ = paymentBuilder.setMainMethod(.vnPayInternationalCardGateway(amount: onlineAmount))
        case .loyalty:
            ()
        case .none:
            let customer = VNPayEWalletCustomer(
                partnerId: tfPartnerID.text ?? "",
                phone: tfPhonenumber.text ?? "",
                name: tfName.text,
                email: tfEmail.text)
        
        
            let _ = paymentBuilder.setMainMethod(
                .all(
                    amount: onlineAmount,
                    metadata: [
                        .vnPayEWallet(customer: customer)
                    ]
                )
            )
        case .spos:
            let _ = paymentBuilder.setMainMethod(.sposApp(amount: onlineAmount))
        case .cod:
            let _ = paymentBuilder.setMainMethod(.cod(amount: onlineAmount))
        }
        
        if let loyaltyAmount = loyalTyAmount, loyaltyAmount > 0 {
            let _ = paymentBuilder.setLoyaltyMethod(points: loyaltyAmount, amount: Double(loyaltyAmount))
        }
        
        let request = paymentBuilder.build()
        do {
            try TerraPaymentUI.getInstance(by: terraApp)?.payWith(request: request, delegate: self)
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func clickPay(_ sender: Any) {
        switch selectedMethod {
        case .loyalty:
            processPaymentWithLoyaltyOnly()
        default:
            processPaymentFtLoyalty()
        }
        
        
    }
    
    @IBAction func clickLoyalty(_ sender: Any) {
        let vc = RouterType.loyalty.getVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension PaymentViewController : AIOPaymentUIDelegate {
    func onPaymentResult(_ result: AIOPaymentResult) {
        switch result {
        case .success(let transactionResult):
            AlertUtils.showAlert(from: self,
                                 with: "Success",
                                 message: "Payment.success with request: \(transactionResult.requestId)")
            transactionResult.transactions.forEach { (transaction) in
                TerraTracker.getInstance(by: terraApp)?.sendPaymentEvent(
                    data: PaymentEventData(
                        orderID: transaction.transactionCode,
                        referral: nil,
                        amount: transaction.amount,
                        paymentMethod: TekoTracker.PaymentMethod.init(rawValue: transaction.methodType.name)!,
                        status: EcommerceEventStatus.success))
            }
            // ?
            
//            transactionResult.transactions.forEach { transaction in
//                
//                TerraTracker.getInstance(by: terraApp)?.sendPaymentEvent(
//                    data: PaymentEventData(
//                        orderID: transactionResult.orderCode,
//                        referral: nil,
//                        amount: transactionResult.amount,
//                        paymentMethod: TekoTracker.PaymentMethod.init(rawValue: transaction.methodType.name),
//                        status: EcommerceEventStatus.success)
//                )
//
//            }
            
        case .failure(let error, let transactionResult):
            if let transactionResult = transactionResult {
                AlertUtils.showAlert(from: self,
                                     with: "Failure",
                                     message: String(describing: error) + ":\n" + String(describing: transactionResult))
                // ?
                transactionResult.transactions.forEach { (transaction) in
                    TerraTracker.getInstance(by: terraApp)?.sendPaymentEvent(
                        data: PaymentEventData(
                            orderID: transactionResult.orderCode,
                            referral: nil,
                            amount: transaction.amount,
                            paymentMethod: TekoTracker.PaymentMethod.init(rawValue: transaction.methodType.name)!,
                            status: EcommerceEventStatus.failed))
                }
//                transactionResult.transactions.forEach { (transaction) in
////                    if transaction.
//                }
            } else {
                AlertUtils.showAlert(from: self, with: "Failure", message: String(describing: error))
            }
            
            
        @unknown default:
            ()
        }
    }
    
    func onPaymentCancel() {
        AlertUtils.showAlert(from: self, with: "Noti", message: "Payment.cancel")
    }
    
    
}
