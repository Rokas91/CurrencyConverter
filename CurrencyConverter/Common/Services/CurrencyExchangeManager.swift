//
//  CurrencyExchangeManager.swift
//  CurrencyConverter
//
//  Created by Rokas on 22/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Bolts
import RealmSwift

class CurrencyExchangeManager: NSObject {
    private let currencyAPIClient: CurrencyAPIClient
    private let toastManager: ToastManager
    private var realm: Realm! {
        return try! Realm()
    }
    
    init (currencyAPIClient: CurrencyAPIClient, toastManager: ToastManager) {
        self.currencyAPIClient = currencyAPIClient
        self.toastManager = toastManager
        super.init()
    }
    
    func getToAmount(fromAmount: Double, fromCurrency: String, toCurrency: String) -> BFTask<AnyObject> {
        return currencyAPIClient.fetchCurrencyRate(fromCurrency: fromCurrency, toCurrency: toCurrency).continue({ task -> Any? in
            let taskCompletionSource = BFTaskCompletionSource<AnyObject>()
            if let error = task.error {
                taskCompletionSource.setError(error)
            } else {
                let rate = task.result as! Double
                let toAmount = fromAmount * rate
                taskCompletionSource.setResult(toAmount as AnyObject)
            }
            return taskCompletionSource.task
        })
    }
    
    func getFromAmount(toAmount: Double, toCurrency: String, fromCurrency: String) -> BFTask<AnyObject> {
        return currencyAPIClient.fetchCurrencyRate(fromCurrency: fromCurrency, toCurrency: toCurrency).continue({ task -> Any? in
            let taskCompletionSource = BFTaskCompletionSource<AnyObject>()
            if let error = task.error {
                taskCompletionSource.setError(error)
            } else {
                let rate = task.result as! Double
                let fromAmmount = toAmount / rate
                taskCompletionSource.setResult(fromAmmount as AnyObject)
            }
            return taskCompletionSource.task
        })
    }
    
    func convert(wallet: Wallet, fromAmmount: Double, fromCurrency: String, toAmount: Double, toCurrency: String) {
        let converTion = Convertion(wallet: wallet, fromAmount: fromAmmount, fromCurrency: fromCurrency, toAmount: toAmount, toCurrency: toCurrency)
        switch converTion.validate() {
        case .valid:
            converTion.calculateAndCommit()
            toastManager.showSuccessNotification()
            break
        case .invalid(let failures):
            toastManager.showErrorNotification(with: (failures.first as! ValidationError).message)
            break
        }
    }
}

