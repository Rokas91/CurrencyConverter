//
//  AccountSection.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Foundation

struct AccountSection {
    let wallet: Wallet
    let currencyBalances: [CurrencyBalance]
    
    init(wallet: Wallet,
         currencyBalances: [CurrencyBalance]) {
        self.wallet = wallet
        self.currencyBalances = currencyBalances
    }
}
