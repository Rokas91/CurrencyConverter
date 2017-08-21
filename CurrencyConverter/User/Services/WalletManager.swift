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
    
    var lastUsedWallet: Wallet {
        get {
            var wallet: Wallet?
            if let walletId = (UserDefaults.standard.object(forKey: "Last-Used-Wallet") as? String) {
                wallet = getWallet(by: walletId)
            }
            
            if let wallet = wallet {
                return wallet
            }
            
            return walletRepository.findAll().first!
        }
        set {
            UserDefaults.setAndSynchronizeObject(newValue.id, forKey: "Last-Used-Wallet")
        }
    }
    
    var lastUsedCurrency: String {
        get {
            if let currencyCode = UserDefaults.standard.string(forKey: "Last-Used-Currency") {
                return currencyCode
            } else {
                return (lastUsedWallet.currencyBalances.first?.currency)!
            }
        }
        set {
            UserDefaults.setAndSynchronizeObject(newValue, forKey: "Last-Used-Currency")
        }
    }
    
    init(walletRepository: WalletRepository) {
        self.walletRepository = walletRepository
        super.init()
    }
    
    func getWallet(by walletId: String) -> Wallet? {
        for wallet in Array(walletRepository.findAll()) {
            if wallet.id == walletId {
                return wallet
            }
        }
        return nil
    }
    
    func getAccountNumber(by walletId: String) -> String? {
        return walletRepository.find(walletId)?.accountNumber
    }
    
    func getCurrencyBalance(walletId: String, currency: String) -> CurrencyBalance? {
        for wallet in Array(walletRepository.findAll()) {
            if wallet.id == walletId {
                for currencyBalance in wallet.currencyBalances {
                    if currencyBalance.currency == currency {
                        return currencyBalance
                    }
                }
            }
        }
        return nil
    }
    
    func createEmptyBalance(of currency: String) -> CurrencyBalance {
        let currencyBalance = CurrencyBalance()
        currencyBalance.setAtDisposal(amount: 0, currency: currency)
        return currencyBalance
    }
}





























