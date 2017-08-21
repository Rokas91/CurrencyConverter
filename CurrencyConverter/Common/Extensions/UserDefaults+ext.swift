//
//  UserDefaults+ext.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Foundation

extension UserDefaults {
    class func setAndSynchronizeObject(_ object: Any, forKey key: String) {
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
