//
//  MainViewController.swift
//  CurrencyConverter
//
//  Created by Rokas on 18/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit
import Typhoon

class MainViewController: BaseViewController {
    var userManager: UserManager!
    var walletManager: WalletManager!
    var accountSelectionViewController: AccountSelectionViewController!
    var upperCurrencySelectionViewController: UpperCurrencySelectionViewController!
    var lowerCurrencySelectionViewController: LowerCurrencySelectionViewController!
    fileprivate let currencies = ["EUR", "USD", "CAD"] //pakeisti i manageri
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let wallet = walletManager.lastUsedWallet
        
        getView().delegate = self
        accountSelectionViewController.delegate = self
        accountSelectionViewController.wallets = userManager.getWallets()
        if let currencyBalance = walletManager.getCurrencyBalance(walletId: wallet.id, currency: walletManager.lastUsedCurrency) {
            accountSelectionViewController.delegate?.onAccountSelected(wallet: wallet, balance: currencyBalance)
        }
        
        upperCurrencySelectionViewController.currencies = currencies
        lowerCurrencySelectionViewController.currencies = currencies.filter { $0 != walletManager.lastUsedCurrency }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Konvertuoti", style: .plain, target: self, action: #selector(convertTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    override func getView() -> MainView {
        return super.getView() as! MainView
    }
}


// MARK: - Selectors

extension MainViewController {
    fileprivate dynamic func convertTapped() {
    }
}

// MARK: - MainViewDelegate

extension MainViewController: MainViewDelegate {
    func onAccountButtonTapped() {
        presentViewControllerInNavigationViewController(accountSelectionViewController, modalPresentationStyle: .overFullScreen, modalTransitionStyle: .crossDissolve)
    }
    
    func onCurrencyExchangeButtonTapped(view: UIView) {
        if view.isKind(of: UpperCurrencyExchangeView.self) {
            presentViewControllerInNavigationViewController(upperCurrencySelectionViewController)
        } else {
            presentViewControllerInNavigationViewController(lowerCurrencySelectionViewController)
        }
    }
}

// MARK: - AccountSelectionViewControllerDelegate

extension MainViewController: AccountSelectionViewControllerDelegate {
    func onAccountSelected(wallet: Wallet, balance: CurrencyBalance) {
        walletManager.lastUsedWallet = wallet
        walletManager.lastUsedCurrency = balance.currency
        accountSelectionViewController.currentWallet = wallet
        accountSelectionViewController.currentCurrency = balance.currency
        
        upperCurrencySelectionViewController.wallet = wallet
        lowerCurrencySelectionViewController.wallet = wallet
        
        var oldCurrentCurrency = upperCurrencySelectionViewController.currentCurrency
        if oldCurrentCurrency == nil {
            oldCurrentCurrency = currencies.filter { $0 != balance.currency }.first
        }
        
        upperCurrencySelectionViewController.currentCurrency = balance.currency
        
        if lowerCurrencySelectionViewController.currentCurrency == upperCurrencySelectionViewController.currentCurrency {
            lowerCurrencySelectionViewController.currentCurrency = oldCurrentCurrency
        } else {
            lowerCurrencySelectionViewController.currentCurrency = currencies.filter { $0 != balance.currency }.first
        }
        
        lowerCurrencySelectionViewController.currencies = currencies.filter { $0 != upperCurrencySelectionViewController.currentCurrency }
        
        getView().accountView.accountLabel.text = wallet.accountNumber
        getView().accountView.balanceLabel.text = "\(balance.atDisposal) \(balance.currency)"
        getView().upperCurrencyExchangeView.flagImageView.setFlag(with: upperCurrencySelectionViewController.currentCurrency!)
        getView().upperCurrencyExchangeView.currencyLabel.text = upperCurrencySelectionViewController.currentCurrency
        getView().lowerCurrencyExchangeView.flagImageView.setFlag(with: lowerCurrencySelectionViewController.currentCurrency!)
        getView().lowerCurrencyExchangeView.currencyLabel.text = lowerCurrencySelectionViewController.currentCurrency
    }
}

// MARK: - CurrencySelectionViewControllerDelegate

extension MainViewController: CurrencySelectionViewControllerDelegate {
    func onCurrencySelected(_ controller: CurrencySelectionViewController, balance: CurrencyBalance) {
        if upperCurrencySelectionViewController == controller {
            
        } else {
            
        }
    }
}



























