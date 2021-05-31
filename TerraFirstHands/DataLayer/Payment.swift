//
//  Payment.swift
//  TerraFirstHands
//
//  Created by Thuy Nguyen on 28/05/2021.
//

import Foundation

enum PaymentMethod : CaseIterable {
    case none
    case loyalty
    case qrMMS
    case qrGateway
    case mobileBanking
    case spos
    case ewallet
    case momoGateway
    case qrReversal
    case atm
    case internationalCard
    case cod
    
    var title: String {
        switch self {
        case .none:
            return "Chọn phương thức thanh toán"
        case .loyalty:
            return "Chỉ điểm thưởng"
        case .qrMMS:
            return "QRCode MMS"
        case .qrGateway:
            return "QRCode Cổng"
        case .mobileBanking:
            return "Mobile Banking"
        case .spos:
            return "Máy spos"
        case .ewallet:
            return "Ví VNPay"
        case .momoGateway:
            return "Ví momo"
        case .qrReversal:
            return "QR Khách hàng"
        case .atm:
            return "Thẻ ATM"
        case .internationalCard:
            return "Thẻ Debit/Credit"
        case .cod:
            return "Thanh toán COD"
        }
    }
}
