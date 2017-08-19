//
//  WalletManager.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Foundation

class WalletManager: NSObject {
    private let walletRepository: WalletRepository
    
    init(walletRepository: WalletRepository) {
        self.walletRepository = walletRepository
        super.init()
    }
    
    func getAccountNumber(by walletId: Int) -> String? {
        return walletRepository.find(walletId)?.accountNumber
    }
}
