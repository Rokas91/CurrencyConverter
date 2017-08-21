//
//  WalletRepository.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import RealmSwift

class WalletRepository: EntityRepository {
    func find(_ id: String) -> Wallet? {
        return realm.object(ofType: Wallet.self, forPrimaryKey: id as AnyObject)
    }
    
    func findAll() -> Results<Wallet> {
        return realm.objects(Wallet.self)
    }
}
