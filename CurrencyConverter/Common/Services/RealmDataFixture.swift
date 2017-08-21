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
            
//            for _ in 1...Int(arc4random_uniform(3) + 1) {
//                let wallet = createWallet(accountNumber: getAccountNumber())
//                realm.add(wallet)
//                user.wallets.append(wallet)
//            }
//            for _ in 0...2 {
                let wallet = createWallet(accountNumber: "LT974642543564365654654")
                realm.add(wallet)
                user.wallets.append(wallet)
//            }
        }
    }
    
    private func createWallet(accountNumber: String) -> Wallet {
        let wallet = Wallet()
        let currencyBalance = CurrencyBalance()
        let currencyBalance1 = CurrencyBalance()
        let currencyBalance2 = CurrencyBalance()
        let currencyBalance3 = CurrencyBalance()
        let currencyBalance4 = CurrencyBalance()
        let currencyBalance5 = CurrencyBalance()
        let currencyBalance6 = CurrencyBalance()
        let currencyBalance7 = CurrencyBalance()
        let currencyBalance8 = CurrencyBalance()
        let currencyBalance9 = CurrencyBalance()
        let currencyBalance10 = CurrencyBalance()
        let currencyBalance11 = CurrencyBalance()
        let currencyBalance12 = CurrencyBalance()
        let currencyBalance13 = CurrencyBalance()
        let currencyBalance14 = CurrencyBalance()
        let currencyBalance15 = CurrencyBalance()
        let currencyBalance16 = CurrencyBalance()
        let currencyBalance17 = CurrencyBalance()
        let currencyBalance18 = CurrencyBalance()
        let currencyBalance19 = CurrencyBalance()
        let currencyBalance20 = CurrencyBalance()
        let currencyBalance21 = CurrencyBalance()
        let currencyBalance22 = CurrencyBalance()
        let currencyBalance23 = CurrencyBalance()
        let currencyBalance24 = CurrencyBalance()
        let currencyBalance25 = CurrencyBalance()
        let currencyBalance26 = CurrencyBalance()
        let currencyBalance27 = CurrencyBalance()
        let currencyBalance28 = CurrencyBalance()
        let currencyBalance29 = CurrencyBalance()
        
        wallet.accountNumber = accountNumber
        
        currencyBalance.currency = "EUR"
        currencyBalance.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance)
        
        currencyBalance1.currency = "BGN"
        currencyBalance1.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance1)
        
        currencyBalance2.currency = "BRL"
        currencyBalance2.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance2)
        
        currencyBalance3.currency = "CAD"
        currencyBalance3.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance3)
        
        currencyBalance4.currency = "CHF"
        currencyBalance4.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance4)
        
        currencyBalance5.currency = "CNY"
        currencyBalance5.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance5)
        
        currencyBalance6.currency = "CZK"
        currencyBalance6.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance6)
        
        currencyBalance7.currency = "DKK"
        currencyBalance7.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance7)
        
        currencyBalance8.currency = "GBP"
        currencyBalance8.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance8)
        
        currencyBalance9.currency = "HKD"
        currencyBalance9.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance9)
        
        currencyBalance10.currency = "HRK"
        currencyBalance10.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance10)
        
        currencyBalance11.currency = "HUF"
        currencyBalance11.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance11)
        
        currencyBalance12.currency = "IDR"
        currencyBalance12.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance12)
        
        currencyBalance13.currency = "ILS"
        currencyBalance13.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance13)
        
        currencyBalance14.currency = "INR"
        currencyBalance14.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance14)
        
        currencyBalance15.currency = "JPY"
        currencyBalance15.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance15)
        
        currencyBalance16.currency = "KRW"
        currencyBalance16.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance16)
        
        currencyBalance17.currency = "MXN"
        currencyBalance17.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance17)
        
        currencyBalance18.currency = "NOK"
        currencyBalance18.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance18)
        
        currencyBalance19.currency = "NZD"
        currencyBalance19.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance19)
        
        currencyBalance20.currency = "PHP"
        currencyBalance20.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance20)
        
        currencyBalance21.currency = "PLN"
        currencyBalance21.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance21)
        
        currencyBalance22.currency = "RON"
        currencyBalance22.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance22)
        
        currencyBalance23.currency = "RUB"
        currencyBalance23.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance23)
        
        currencyBalance24.currency = "SEK"
        currencyBalance24.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance24)
        
        currencyBalance25.currency = "SGD"
        currencyBalance25.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance25)
        
        currencyBalance26.currency = "THB"
        currencyBalance26.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance26)
        
        currencyBalance27.currency = "TRY"
        currencyBalance27.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance27)
        
        currencyBalance28.currency = "USD"
        currencyBalance28.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance28)
        
        currencyBalance29.currency = "ZAR"
        currencyBalance29.atDisposal = Int(arc4random_uniform(10000))
        wallet.currencyBalances.append(currencyBalance29)
        
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







































