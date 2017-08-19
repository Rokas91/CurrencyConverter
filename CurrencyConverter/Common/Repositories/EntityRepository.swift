//
//  EntityRepository.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import RealmSwift

class EntityRepository: NSObject {
    var realm: Realm! {
        return try! Realm()
    }
}
