//
//  EmbeddedTableViewController.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class EmbeddedTableViewController: UITableViewController {
    func getTable() -> UITableView {
        return tableView
    }
    
    func setTable(_ tableView: UITableView) {
        self.tableView = tableView
        viewDidLoad()
    }
}
