//
//  SplashPresenter.swift
//  TerraFirstHands
//
//  Created by Teko on 26/05/2021.
//

import Foundation

class SplashPresenter : SplashPresenterProtocol {
    
    weak private var view: SplashViewProtocol?
    
    var dismissHandler: (() -> Void)?
    
    init(view: SplashViewProtocol, dismissHandler: @escaping () -> Void) {
        self.view = view
        self.dismissHandler = dismissHandler
    }
    
    func initData() {
        TerraInstanceCenter.shared.loadTerra {[weak self] (isSuccess) in
            guard isSuccess else {
                self?.view?.showMessage("Failed to load Terra")
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.view?.dismiss()
                self?.dismissHandler?()
            }
        }
    }
}
