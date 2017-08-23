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
    
    func getCurrencyBalance(by currency: String) -> CurrencyBalance {
        for currencyBalance in currencyBalances {
            if currencyBalance.currency == currency {
                return currencyBalance
            }
        }
        return createEmptyBalance(of: currency)
    }
    
    private func createEmptyBalance(of currency: String) -> CurrencyBalance {
        let currencyBalance = CurrencyBalance()
        currencyBalance.setAtDisposal(amount: 0, currency: currency)
        return currencyBalance
    }
}

class CurrencyBalance: Object {
    dynamic var id = UUID().uuidString
    dynamic var currency = ""
    dynamic var atDisposal: Double = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func setAtDisposal(amount: Double, currency: String) {
        self.atDisposal = amount
        self.currency = currency
    }
}
