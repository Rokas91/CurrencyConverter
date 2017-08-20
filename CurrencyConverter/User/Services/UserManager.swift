//
//  UserManager.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Foundation

class UserManager: NSObject {
    private let userRepository: UserRepository
    
    var user: User? {
        return userRepository.findFirst()
    }
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}
