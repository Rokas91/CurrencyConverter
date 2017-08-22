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
    var currencyManager: CurrencyManager!
    fileprivate var wallet: Wallet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let wallet = walletManager.lastUsedWallet
        
        getView().delegate = self
        accountSelectionViewController.delegate = self
        upperCurrencySelectionViewController.delegate = self
        lowerCurrencySelectionViewController.delegate = self
        accountSelectionViewController.wallets = userManager.getWallets()
        if let currencyBalance = walletManager.getCurrencyBalance(walletId: wallet.id, currency: walletManager.lastUsedCurrency) {
            accountSelectionViewController.delegate?.onAccountSelected(wallet: wallet, balance: currencyBalance)
        }
        
        upperCurrencySelectionViewController.currencies = currencyManager.getCurrencies()
        lowerCurrencySelectionViewController.currencies = currencyManager.getCurrencies().filter { $0 != walletManager.lastUsedCurrency }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Konvertuoti", style: .plain, target: self, action: #selector(convertTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    override func getView() -> MainView {
        return super.getView() as! MainView
    }
    
    fileprivate func configureCurrencySelection(balance: CurrencyBalance) {
        var oldCurrentCurrency = upperCurrencySelectionViewController.currentCurrency
        if oldCurrentCurrency == nil {
            oldCurrentCurrency = currencyManager.getCurrencies().filter { $0 != balance.currency }.first
        }
        
        upperCurrencySelectionViewController.currentCurrency = balance.currency
        
        if lowerCurrencySelectionViewController.currentCurrency == upperCurrencySelectionViewController.currentCurrency {
            lowerCurrencySelectionViewController.currentCurrency = oldCurrentCurrency
        } else {
            lowerCurrencySelectionViewController.currentCurrency = wallet.currencyBalances.sorted { $0.atDisposal > $1.atDisposal }.filter { $0.currency != balance.currency }.first?.currency
        }
        
        lowerCurrencySelectionViewController.currencies = currencyManager.getCurrencies().filter { $0 != upperCurrencySelectionViewController.currentCurrency }
    }
    
    fileprivate func layoutAccounView(wallet: Wallet, balance: CurrencyBalance) {
        getView().accountView.accountLabel.text = wallet.accountNumber
        getView().accountView.balanceLabel.text = String.formatTo2f(balance.atDisposal) + " " + balance.currency
    }
    
    fileprivate func layoutCurrencyExchangeView() {
        getView().upperCurrencyExchangeView.flagImageView.setFlag(with: upperCurrencySelectionViewController.currentCurrency!)
        getView().upperCurrencyExchangeView.currencyLabel.text = upperCurrencySelectionViewController.currentCurrency
        getView().lowerCurrencyExchangeView.flagImageView.setFlag(with: lowerCurrencySelectionViewController.currentCurrency!)
        getView().lowerCurrencyExchangeView.currencyLabel.text = lowerCurrencySelectionViewController.currentCurrency
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
        self.wallet = wallet
        walletManager.lastUsedWallet = wallet
        walletManager.lastUsedCurrency = balance.currency
        accountSelectionViewController.currentWallet = wallet
        accountSelectionViewController.currentCurrency = balance.currency
        
        upperCurrencySelectionViewController.wallet = wallet
        lowerCurrencySelectionViewController.wallet = wallet
        configureCurrencySelection(balance: balance)
        layoutAccounView(wallet: wallet, balance: balance)
        layoutCurrencyExchangeView()
    }
}

// MARK: - CurrencySelectionViewControllerDelegate

extension MainViewController: CurrencySelectionViewControllerDelegate {
    func onCurrencySelected(_ controller: CurrencySelectionViewController, balance: CurrencyBalance) {
        if upperCurrencySelectionViewController == controller {
            accountSelectionViewController.delegate?.onAccountSelected(wallet: wallet, balance: balance)
        } else {
            lowerCurrencySelectionViewController.currentCurrency = balance.currency
        }
        layoutCurrencyExchangeView()
    }
}



























