//
//  UserRepository.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import RealmSwift

class UserRepository: EntityRepository {
    func findFirst() -> User? {
        return realm.objects(User.self).first
    }
}
