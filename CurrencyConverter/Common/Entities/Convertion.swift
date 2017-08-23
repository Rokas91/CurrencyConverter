//
//  Convertion.swift
//  CurrencyConverter
//
//  Created by Rokas on 22/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import RealmSwift
import Validator

struct Convertion {
    private let wallet: Wallet
    private let fromAmount: Double
    private let fromCurrency: String
    private let toAmount: Double
    private let toCurrency: String
    
    private var realm: Realm! {
        return try! Realm()
    }
    
    init(wallet: Wallet, fromAmount: Double, fromCurrency: String, toAmount: Double, toCurrency: String) {
        self.wallet = wallet
        self.fromAmount = fromAmount
        self.fromCurrency = fromCurrency
        self.toAmount = toAmount
        self.toCurrency = toCurrency
    }
    
    func validate() -> ValidationResult {
        return ValidationResult.merge(results: [
            Validator.validate(
                input: Money(amount: fromAmount),
                rule: ValidationRuleAmountIsNotZero()
            ),
            Validator.validate(
                input: Money(amount: toAmount),
                rule: ValidationRuleAmountIsNotZero()
            ),
            Validator.validate(
                input: Money(fromAmount: fromAmount, atDisposal: getAtDisposal()),
                rule: ValidationRuleAmountIsNotGreater()
            )
            ])
    }
    
    func calculateAndCommit() {
        try! realm.write {
            let fromCurrencyBalance = wallet.getCurrencyBalance(by: fromCurrency)
            let toCurrencyBalance = wallet.getCurrencyBalance(by: toCurrency)
            fromCurrencyBalance.atDisposal = fromCurrencyBalance.atDisposal - fromAmount
            if toCurrencyBalance.atDisposal == 0 {
                wallet.currencyBalances.append(toCurrencyBalance)
            }
            toCurrencyBalance.atDisposal = toCurrencyBalance.atDisposal + toAmount
        }
    }
    
    private func getAtDisposal() -> Double {
        return wallet.getCurrencyBalance(by: fromCurrency).atDisposal
    }
}
