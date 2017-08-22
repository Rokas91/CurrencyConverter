//
//  CurrencyManager.swift
//  CurrencyConverter
//
//  Created by Rokas on 22/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Bolts
import TMCache

class CurrencyManager: NSObject {
    private let currencyAPIClient: CurrencyAPIClient
    
    init(currencyAPIClient: CurrencyAPIClient) {
        self.currencyAPIClient = currencyAPIClient
        super.init()
    }
    
    func synchronizeCurrencies() {
        currencyAPIClient.getAvailableCurrencies().continue({ task -> Any? in
            if let error = task.error {
                print(error)
            } else {
                let currencies = task.result as! [String]
                self.set(currencies: currencies)
            }
            return nil
        })
    }
    
    func getCurrencies() -> [String] {
        let currencies = TMCache.shared().object(forKey: "availableCurrencies") as? [String]
        if let currencies = currencies, currencies.count > 0 {
            return currencies
        }
        else {
            return getLocalCurrencies()
        }
    }
    
    private func getLocalCurrencies() -> [String] {
        return ["RON", "MYR", "CAD", "DKK", "GBP", "PHP", "CZK", "PLN", "RUB", "SGD", "BRL", "JPY", "SEK", "USD", "HRK", "NZD", "HKD", "BGN", "TRY", "MXN", "HUF", "KRW", "NOK", "INR", "ILS", "IDR", "CHF", "THB", "CNY", "ZAR", "AUD", "EUR"].shuffled()
    }

    private func set(currencies: [String]) {
        TMCache.shared().setObject(currencies as NSCoding, forKey: "availableCurrencies")
    }
    
}
