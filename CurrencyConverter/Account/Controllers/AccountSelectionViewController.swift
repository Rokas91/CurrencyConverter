//
//  AccountViewController.swift
//  CurrencyConverter
//
//  Created by Rokas on 18/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

protocol AccountSelectionViewControllerDelegate: class {
    func onAccountSelected(wallet: Wallet, balance: CurrencyBalance, isCurrencySelectionTriggered: Bool)
}

class AccountSelectionViewController: BaseViewController {
    weak var delegate: AccountSelectionViewControllerDelegate?
    private let accountSelectionTableViewController: AccountSelectionTableViewController
    
    var currentWallet: Wallet? {
        didSet{
            accountSelectionTableViewController.currentWallet = currentWallet
        }
    }
    var currentCurrency: String? {
        didSet{
            accountSelectionTableViewController.currentCurrency = currentCurrency
        }
    }
    var wallets = [Wallet]() {
        didSet{
            accountSelectionTableViewController.wallets = wallets
        }
    }

    init(accountSelectionTableViewController: AccountSelectionTableViewController) {
        self.accountSelectionTableViewController = accountSelectionTableViewController
        super.init()
    }
    
    override func viewDidLoad() {
        accountSelectionTableViewController.setTable(getView().accountSelectionTableView)
        accountSelectionTableViewController.reloadTable()
        super.viewDidLoad()
        
        getView().delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(onBackTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        accountSelectionTableViewController.reloadTable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func getView() -> AccountSelectionView {
        return super.getView() as! AccountSelectionView
    }
}

// MARK: - AccountSelectionViewDelegate

extension AccountSelectionViewController: AccountSelectionViewDelegate {
    func onAccountSelected(wallet: Wallet, balance: CurrencyBalance) {
        delegate?.onAccountSelected(wallet: wallet, balance: balance, isCurrencySelectionTriggered: true)
        dismiss(animated: true)
    }
}
