//
//  AccountSelectionTableViewController.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class AccountSelectionTableViewController: EmbeddedTableViewController {
    override func getTable() -> AccountSelectionTableView {
        return tableView as! AccountSelectionTableView
    }
}
