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
    private let walletManager: WalletManager
    
    init(
        userRepository: UserRepository,
        walletManager: WalletManager
        ) {
        self.userRepository = userRepository
        self.walletManager = walletManager
    }
    
    func getUser() -> User? {
        return userRepository.findFirst()
    }
}
