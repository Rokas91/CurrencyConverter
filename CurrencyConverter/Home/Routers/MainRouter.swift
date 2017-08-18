//
//  MainRouter.swift
//  CurrencyConverter
//
//  Created by Rokas on 18/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class MainRouter: Router {
    private let accountAssembly: AccountAssembly
    
    init(
        accountAssembly: AccountAssembly
        ) {
        self.accountAssembly = accountAssembly
        super.init()
    }
    
    func showTestTransfer() {
        let controller = accountAssembly.accountViewController() as! UIViewController
        goToViewController(controller)
    }
}
