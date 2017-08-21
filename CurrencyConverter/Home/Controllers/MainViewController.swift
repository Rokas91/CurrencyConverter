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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getView().delegate = self
        accountSelectionViewController.delegate = self
        accountSelectionViewController.wallets = userManager.getWallets()
//        accountSelectionViewController.currentWallet = walletManager.lastUsedWallet
//        accountSelectionViewController.currentCurrency = walletManager.lastUsedCurrency
        accountSelectionViewController.currentWallet = userManager.getWallets().first!
        print("logas currentWallet \(accountSelectionViewController.currentWallet)")
        accountSelectionViewController.currentCurrency = "EUR"
        
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
            
        } else {
            
        }
    }
}

// MARK: - AccountSelectionViewControllerDelegate

extension MainViewController: AccountSelectionViewControllerDelegate {
    func onAccountSelected(wallet: Wallet, balance: CurrencyBalance) {
        
    }
}




























