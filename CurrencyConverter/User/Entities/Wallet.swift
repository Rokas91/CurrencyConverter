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
    dynamic var atDisposal: Double = 0
    
    func setAtDisposal(amount: Double, currency: String) {
        self.atDisposal = amount
        self.currency = currency
    }
}
