//
//  User.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import RealmSwift

class User: Object {
    dynamic var id = UUID().uuidString
    dynamic var selectedWallet: Wallet!
    var wallets = List<Wallet>()

    override static func primaryKey() -> String? {
        return "id"
    }
}
