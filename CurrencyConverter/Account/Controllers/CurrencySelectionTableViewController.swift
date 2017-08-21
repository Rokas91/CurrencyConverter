//
//  CurrencySelectionTableViewController.swift
//  CurrencyConverter
//
//  Created by Rokas on 21/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class CurrencySelectionTableViewController: EmbeddedTableViewController {
    var walletManager: WalletManager!
    var wallet: Wallet?
    var currentCurrency: String?
    var currencies = [String]() 
    
    private var currencyBalances: [CurrencyBalance] {
        if let wallet = wallet {
            var currencyBalances = [CurrencyBalance]()
            currencies.forEach { currency in
                var currencyBalance: CurrencyBalance?
                if let balance = walletManager.getCurrencyBalance(walletId: wallet.id, currency: currency) {
                    currencyBalance = balance
                } else {
                    currencyBalance = walletManager.createEmptyBalance(of: currency)
                }
                currencyBalances.append(currencyBalance!)
            }
            return currencyBalances.sorted { $0.atDisposal > $1.atDisposal }
        }
        return [CurrencyBalance]()
    }
    
    override func getTable() -> CurrencySelectionTableView {
        return tableView as! CurrencySelectionTableView
    }
    
    func reloadTable() {
        getTable().currencyBalances = currencyBalances
        getTable().currentCurrency = currentCurrency
        getTable().reloadData()
    }

}
