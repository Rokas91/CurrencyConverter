//
//  AccountViewController.swift
//  CurrencyConverter
//
//  Created by Rokas on 18/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

protocol AccountSelectionViewControllerDelegate: class {
    func onAccountSelected(wallet: Wallet, balance: CurrencyBalance)
}

class AccountSelectionViewController: BaseViewController {
    weak var delegate: AccountSelectionViewControllerDelegate?
    var currentWallet: Wallet? 
    var currentCurrency: String?
    var wallets = [Wallet]()
    private let accountSelectionTableViewController: AccountSelectionTableViewController

    private var sections: [AccountSection] {
        var sections = [AccountSection]()
        wallets.forEach {
            sections.append(AccountSection(wallet: $0, currencyBalances: Array($0.currencyBalances)))
        }
        return sections
    }
    
    init(accountSelectionTableViewController: AccountSelectionTableViewController) {
        self.accountSelectionTableViewController = accountSelectionTableViewController
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getView().delegate = self
        accountSelectionTableViewController.setTable(getView().accountSelectionTableView)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(onBackTapped))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        accountSelectionTableViewController.getTable().currentWallet = currentWallet
        accountSelectionTableViewController.getTable().currentCurrency = currentCurrency
        accountSelectionTableViewController.getTable().sections = sections
        accountSelectionTableViewController.getTable().reloadData()
    }
    
    override func getView() -> AccountSelectionView {
        return super.getView() as! AccountSelectionView
    }

}

extension AccountSelectionViewController: AccountSelectionViewDelegate {
    func onAccountSelected(wallet: Wallet, balance: CurrencyBalance) {
        delegate?.onAccountSelected(wallet: wallet, balance: balance)
    }
}
