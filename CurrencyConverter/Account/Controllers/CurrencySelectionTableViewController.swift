//
//  CurrencySelectionTableViewController.swift
//  CurrencyConverter
//
//  Created by Rokas on 21/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class CurrencySelectionTableViewController: EmbeddedTableViewController {
    var wallet: Wallet?
    var currentCurrency: String?
    var currencies = [String]() 
    
    private var currencyBalances: [CurrencyBalance] {
        if let wallet = wallet {
            var currencyBalances = [CurrencyBalance]()
            currencies.forEach { currency in
                currencyBalances.append(wallet.getCurrencyBalance(by: currency))
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
