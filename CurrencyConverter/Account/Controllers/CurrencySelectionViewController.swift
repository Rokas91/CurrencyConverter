//
//  CurrencySelectionViewController.swift
//  CurrencyConverter
//
//  Created by Rokas on 21/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

protocol CurrencySelectionViewControllerDelegate: class {
    func onCurrencySelected(_ controller: CurrencySelectionViewController, balance: CurrencyBalance)
}

class CurrencySelectionViewController: BaseViewController {
    weak var delegate: CurrencySelectionViewControllerDelegate?
    private let currencySelectionTableViewController: CurrencySelectionTableViewController
    
    var wallet: Wallet? {
        didSet {
            currencySelectionTableViewController.wallet = wallet
        }
    }
    
    var currentCurrency: String? {
        didSet {
            currencySelectionTableViewController.currentCurrency = currentCurrency
        }
    }
    
    var currencies = [String]() {
        didSet {
            currencySelectionTableViewController.currencies = currencies
        }
    }

    init(currencySelectionTableViewController: CurrencySelectionTableViewController) {
        self.currencySelectionTableViewController = currencySelectionTableViewController
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getView().delegate = self
                currencySelectionTableViewController.setTable(getView().currencySelectionTableView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(onBackTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currencySelectionTableViewController.reloadTable()
    }
    
    override func getView() -> CurrencySelectionView {
        return super.getView() as! CurrencySelectionView
    }
}

// MARK: - CurrencySelectionViewDelegate

extension CurrencySelectionViewController: CurrencySelectionViewDelegate {
    func onCurrencySelected(balance: CurrencyBalance) {
        delegate?.onCurrencySelected(self, balance: balance)
        dismiss(animated: true)
    }
}

