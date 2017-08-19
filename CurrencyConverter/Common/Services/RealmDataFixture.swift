//
//  RealmDataFixture.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import RealmSwift

class RealmDataFixture: NSObject {
    func loadData() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
            
            let user = User()
            realm.add(user)
            
            for _ in 1...Int(arc4random_uniform(3)) {
                let wallet = createWallet(accountNumber: getAccountNumber())
                realm.add(wallet)
                user.wallets.append(wallet)
            }
            user.selectedWallet = user.wallets.first
        }
    }
    
    private func createWallet(accountNumber: String) -> Wallet {
        let wallet = Wallet()
        let currencyBalance = CurrencyBalance()
        
        wallet.accountNumber = accountNumber
        currencyBalance.currency = "EUR"
        currencyBalance.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance)
        
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
