//
//  ApplicationUpdateNotifierListener.swift
//  CurrencyConverter
//
//  Created by Rokas on 22/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Foundation

class ApplicationUpdateNotifierListener: NSObject {
    var userManager: UserManager!
    var realmDataFixture: RealmDataFixture!
    var currencyManager: CurrencyManager!
    
    override init() {
        super.init()

        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(onApplicationLaunched),
                name: NSNotification.Name(EVENT_APPLICATION_DID_FINISH_LAUNCHING),
                object: nil
        )
    }
    
    func onApplicationLaunched() {
        currencyManager.synchronizeCurrencies()
        if userManager.user == nil {
            realmDataFixture.loadData()
        }
    }
}
