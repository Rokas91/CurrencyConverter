//
//  AccountSelectionTableViewController.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class AccountSelectionTableViewController: EmbeddedTableViewController {
    var currentWallet: Wallet? 
    var currentCurrency: String?
    var wallets = [Wallet]()
    
    private var sections: [AccountSection] {
        var sections = [AccountSection]()
        wallets.forEach {
            sections.append(AccountSection(wallet: $0, currencyBalances: Array($0.currencyBalances)))
        }
        return sections
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func getTable() -> AccountSelectionTableView {
        return tableView as! AccountSelectionTableView
    }
    
    func reloadTable() {
        getTable().currentWallet = currentWallet
        getTable().currentCurrency = currentCurrency
        getTable().sections = sections
        getTable().reloadData()
    }
}
