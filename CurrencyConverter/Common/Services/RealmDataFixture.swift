//
//  RealmDataFixture.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import RealmSwift

class RealmDataFixture: NSObject {
    private let currencyManager: CurrencyManager
    
    init(currencyManager: CurrencyManager) {
        self.currencyManager = currencyManager
    }
    
    func loadData() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
            
            let user = User()
            realm.add(user)
            
            for _ in 1...Int(arc4random_uniform(3) + 1) {
                let wallet = createWallet(accountNumber: getAccountNumber())
                realm.add(wallet)
                user.wallets.append(wallet)
            }
        }
    }
    
    private func createWallet(accountNumber: String) -> Wallet {
        let wallet = Wallet()
        let currencies = currencyManager.getCurrencies().shuffled()
        
        wallet.accountNumber = accountNumber
        
        for index in 0...Int.random(lower: 1, upper: 5) {
            let currencyBalance = CurrencyBalance()
            currencyBalance.currency = currencies[index]
            currencyBalance.atDisposal = Double.random(lower: 0, upper: 1000)
            wallet.currencyBalances.append(currencyBalance)
        }
        return wallet
    }
    
    private func getAccountNumber() -> String {
        var accountNumber = "LT"
        for _ in 0...17 {
            accountNumber = accountNumber + "\(arc4random_uniform(10))"
        }
        return accountNumber
    }
}








































