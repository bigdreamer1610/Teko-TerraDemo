//
//  MainViewController.swift
//  MiniApp
//
//  Created by linhvt on 11/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import MAPaymentKit

class MainViewController: UIViewController {

    @IBOutlet weak var orderCodeTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func paymentButtonWasTapped(_ sender: Any) {
        guard let orderCode = orderCodeTextField.text,
              let amount = Double(amountTextField.text ?? "") else {
            return
        }
        PaymentKit.shared.pay(paymentRequest: .init(orderCode: orderCode, amount: amount, merchantCode: "TRIPI", shouldShowResultPage: false)) { result in
            switch result {
            case .success(let info):
                self.showResult(info: info)
            case .failure(let error):
                switch error {
                case .timeOut:
                    self.show(warning: "Time out")
                case .cancelled: ()
                //                    self.show(warning: "Cancelled")
                case .unexpected:
                    self.show(warning: "Unexpected error")
                case .failure(let info):
                    self.showResult(info: info)
                }
            }
        }
    }
    
    @IBAction func paymentQRCodeButtonWasTapped(_ sender: Any) {
        guard let orderCode = orderCodeTextField.text,
              let amount = Double(amountTextField.text ?? "") else {
            return
        }
        PaymentKit.shared.payWithQRCode(paymentRequest: .init(orderCode: orderCode, amount: amount, merchantCode: "TRIPI", shouldShowResultPage: false)) { result in
            switch result {
            case .success(let info):
                self.showResult(info: info)
            case .failure(let error):
                switch error {
                case .timeOut:
                    self.show(warning: "Time out")
                case .cancelled: ()
                //                    self.show(warning: "Cancelled")
                case .unexpected:
                    self.show(warning: "Unexpected error")
                case .failure(let info):
                    self.showResult(info: info)
                }
            }
        }
    }

    
    @IBAction func paymentQRReversalButtonWasTapped(_ sender: Any) {
        guard let orderCode = orderCodeTextField.text,
              let amount = Double(amountTextField.text ?? "") else {
            return
        }
        PaymentKit.shared.payWithQRReversal(paymentRequest: .init(orderCode: orderCode, amount: amount, merchantCode: "TRIPI", shouldShowResultPage: false)) { result in
            switch result {
            case .success(let info):
                self.showResult(info: info)
            case .failure(let error):
                switch error {
                case .timeOut:
                    self.show(warning: "Time out")
                case .cancelled: ()
                //                    self.show(warning: "Cancelled")
                case .unexpected:
                    self.show(warning: "Unexpected error")
                case .failure(let info):
                    self.showResult(info: info)
                }
            }
        }
    }

    
    func showResult(info: PaymentKit.PaymentInfo) {
        self.show(
            warning:"""
Payment \(info.code == "SUCCESS" ? "successful" : "fail" ) with info:
- requestId: \(info.paymentRequestId ?? "--")
- transactionCode: \(info.transactionCode ?? "--")
"""
        )
        
    }


    @IBAction func backButtonWasTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension UIViewController {
    
    func show(warning: String) {
        let alert = UIAlertController(title: NSLocalizedString("Result", comment: ""), message: warning, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
