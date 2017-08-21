//
//  Wallet.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import RealmSwift

class Wallet: Object {
    dynamic var id = UUID().uuidString
    dynamic var accountNumber = ""
    let currencyBalances = List<CurrencyBalance>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class CurrencyBalance: Object {
    dynamic var currency = ""
    dynamic var atDisposal = 0
    
    func setAtDisposal(amount: Int, currency: String) {
        self.atDisposal = amount
        self.currency = currency
    }
    
    static func createEmptyBalanceWithCurrencyCode(_ currency: String) -> CurrencyBalance {
        let currencyBalance = CurrencyBalance()
        currencyBalance.setAtDisposal(amount: 0, currency: currency)
        return currencyBalance
    }
}
