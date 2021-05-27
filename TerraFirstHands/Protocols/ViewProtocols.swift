//
//  ViewProtocols.swift
//  TerraFirstHands
//
//  Created by Teko on 26/05/2021.
//

import Foundation

protocol LoadingProtocol {
    func showLoading()
    func hideLoading()
}

protocol ShowMessageProtocol {
    func showMessage(_ message: String)
}
