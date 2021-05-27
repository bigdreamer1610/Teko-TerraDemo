//
//  SplashProtocols.swift
//  TerraFirstHands
//
//  Created by Teko on 26/05/2021.
//

import Foundation

// Builder
protocol SplashBuilderProtocol: class {
    
}

//presenter

protocol SplashPresenterProtocol: class {
    func initData()
}

protocol SplashViewProtocol: class, ShowMessageProtocol {
    var presenter: SplashPresenterProtocol? { get }
    func dismiss()
}
