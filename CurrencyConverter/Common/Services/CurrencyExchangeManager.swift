//
//  CurrencyExchangeManager.swift
//  CurrencyConverter
//
//  Created by Rokas on 22/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Bolts

class CurrencyExchangeManager: NSObject {
    
    var currencyAPIClient: CurrencyAPIClient!
    
    func convert(wallet: Wallet, fromAmmount: Double, fromCurrency: String, toAmount: Double, toCurrency: String) {
//        currencyExchangeAPIClient.fetchCurrencyRates(baseCurrency: fromCurrency).continueWith { task in
//            if task.error == nil {
//                let beneficiary = PayseraTransferBeneficiary()
//                beneficiary.accountNumber = (task.result as! String)
//                let transfer = PayseraTransfer(wallet: wallet, beneficiary: beneficiary, amount: amount)
//                transfer.details = "-"
//                
//                switch transfer.validate() {
//                case .valid:
//                    self.makePayseraTransfer(transfer)
//                case .invalid(let failures):
//                    self.toastManager.showErrorNotification(withMessage: (failures.first as! ValidationError).message)
//                    self.getView().slideConfirmationView.reset()
//                }
//            }
//            return nil
//        }
        
        currencyAPIClient.fetchCurrencyRates(baseCurrency: fromCurrency).continue({ task -> Any? in
            if task.error == nil {
                let rates = task.result as! Dictionary<String, String>
            } else {
                
            }
            return nil
        })
    }
    
}
