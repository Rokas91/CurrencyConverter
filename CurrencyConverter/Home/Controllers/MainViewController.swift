//
//  MainViewController.swift
//  CurrencyConverter
//
//  Created by Rokas on 18/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit
import Typhoon
import RealmSwift

class MainViewController: BaseViewController {
    var userManager: UserManager!
    var walletManager: WalletManager!
    var accountSelectionViewController: AccountSelectionViewController!
    var upperCurrencySelectionViewController: UpperCurrencySelectionViewController!
    var lowerCurrencySelectionViewController: LowerCurrencySelectionViewController!
    var currencyManager: CurrencyManager!
    var currencyExchangeManager: CurrencyExchangeManager!
    var toastManager: ToastManager!
    fileprivate var wallet: Wallet!
    fileprivate var fromAmount: Double?
    fileprivate var toAmount: Double?
    fileprivate var isUpperTextFieldTriggered: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let wallet = walletManager.lastUsedWallet
        let currencyBalance = wallet.getCurrencyBalance(by: walletManager.lastUsedCurrency)
        
        getView().delegate = self
        accountSelectionViewController.delegate = self
        upperCurrencySelectionViewController.delegate = self
        lowerCurrencySelectionViewController.delegate = self
        accountSelectionViewController.wallets = userManager.getWallets()
        accountSelectionViewController.delegate?.onAccountSelected(wallet: wallet, balance: currencyBalance, isCurrencySelectionTriggered: true)
        upperCurrencySelectionViewController.currencies = currencyManager.getCurrencies()
        lowerCurrencySelectionViewController.currencies = currencyManager.getCurrencies().filter { $0 != walletManager.lastUsedCurrency }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Konvertuoti", style: .plain, target: self, action: #selector(convertTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let isUpperTextFieldTriggered = isUpperTextFieldTriggered {
            if isUpperTextFieldTriggered {
                getView().upperCurrencyExchangeView.amountTextField.becomeFirstResponder()
            } else {
                getView().lowerCurrencyExchangeView.amountTextField.becomeFirstResponder()
            }
        } else {
            getView().upperCurrencyExchangeView.amountTextField.becomeFirstResponder()
        }
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
            if lowerCurrencySelectionViewController.currentCurrency == nil {
                lowerCurrencySelectionViewController.currentCurrency = wallet.currencyBalances.sorted { $0.atDisposal > $1.atDisposal }.filter { $0.currency != balance.currency }.first?.currency
            }
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
    
    fileprivate func handleAmountTextField() {
        if let isUpperTextFieldTriggered = isUpperTextFieldTriggered, isUpperTextFieldTriggered {
            if let text = getView().upperCurrencyExchangeView.amountTextField.text, !text.isEmpty {
                let formatter = NumberFormatter()
                let fromAmount = Double(formatter.number(from: text)!)
                let fromCurrency = upperCurrencySelectionViewController.currentCurrency!
                let toCurrency = lowerCurrencySelectionViewController.currentCurrency!
                
                currencyExchangeManager.getToAmount(fromAmount: fromAmount, fromCurrency: fromCurrency, toCurrency: toCurrency).continue({ task -> Any? in
                    if let error = task.error {
                        print(error)
                    } else {
                        let toAmount = task.result as! Double
                        self.toAmount = toAmount
                        let text = String.formatTo2f(toAmount.round(to: 2)).replacingOccurrences(of: ".", with: ",")
                        self.getView().lowerCurrencyExchangeView.amountTextField.text = text
                    }
                    return nil
                })
            }
        } else if let isUpperCurrencySelection = isUpperTextFieldTriggered, !isUpperCurrencySelection {
            if let text = getView().lowerCurrencyExchangeView.amountTextField.text, !text.isEmpty {
                let formatter = NumberFormatter()
                let toAmount = Double(formatter.number(from: text)!)
                let fromCurrency = upperCurrencySelectionViewController.currentCurrency!
                let toCurrency = lowerCurrencySelectionViewController.currentCurrency!
                
                currencyExchangeManager.getFromAmount(toAmount: toAmount, toCurrency: toCurrency, fromCurrency: fromCurrency).continue({ task -> Any? in
                    if let error = task.error {
                        print(error)
                    } else {
                        let fromAmount = task.result as! Double
                        self.fromAmount = fromAmount
                        let text = String.formatTo2f(fromAmount.round(to: 2)).replacingOccurrences(of: ".", with: ",")
                        self.getView().upperCurrencyExchangeView.amountTextField.text = text
                    }
                    return nil
                })
            }
        }
    }
}


// MARK: - Selectors

extension MainViewController {
    fileprivate dynamic func convertTapped() {
        let fromCurrency = upperCurrencySelectionViewController.currentCurrency!
        let toCurrency = lowerCurrencySelectionViewController.currentCurrency!
        if let isUpperCurrencySelection = isUpperTextFieldTriggered, isUpperCurrencySelection {
            if let fromAmount = fromAmount {
                currencyExchangeManager.getToAmount(fromAmount: fromAmount, fromCurrency: fromCurrency, toCurrency: toCurrency).continue({ task -> Any? in
                    if let error = task.error {
                        self.toastManager.showErrorNotification(with: ERROR_MESSAGE)
                        print(error)
                    } else {
                        let toAmount = task.result as! Double
                        self.currencyExchangeManager.convert(wallet: self.wallet, fromAmount: fromAmount, fromCurrency: fromCurrency, toAmount: toAmount, toCurrency: toCurrency) {
                            self.layoutAccounView(wallet: self.wallet, balance: self.wallet.getCurrencyBalance(by: fromCurrency))
                        }
                    }
                    return nil
                })
            }
        } else if let isUpperCurrencySelection = isUpperTextFieldTriggered, !isUpperCurrencySelection {
            if let toAmount = toAmount {
                currencyExchangeManager.getFromAmount(toAmount: toAmount, toCurrency: toCurrency, fromCurrency: fromCurrency).continue({ task -> Any? in
                    if let error = task.error {
                        self.toastManager.showErrorNotification(with: ERROR_MESSAGE)
                        print(error)
                    } else {
                        let fromAmount = task.result as! Double
                        self.currencyExchangeManager.convert(wallet: self.wallet, fromAmount: fromAmount, fromCurrency: fromCurrency, toAmount: toAmount, toCurrency: toCurrency) {
                            self.layoutAccounView(wallet: self.wallet, balance: self.wallet.getCurrencyBalance(by: fromCurrency))
                        }
                    }
                    return nil
                })
            }
        }
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
    
    func onTextFieldDidChange(view: UIView, amount: Double?) {
        let fromCurrency = upperCurrencySelectionViewController.currentCurrency!
        let toCurrency = lowerCurrencySelectionViewController.currentCurrency!
        if view.isKind(of: UpperCurrencyExchangeView.self) {
            fromAmount = amount
            if let fromAmount = fromAmount {
                navigationItem.rightBarButtonItem?.isEnabled = true
                currencyExchangeManager.getToAmount(fromAmount: fromAmount, fromCurrency: fromCurrency, toCurrency: toCurrency).continue({ task -> Any? in
                    if let error = task.error {
                        print(error)
                    } else {
                        let toAmount = task.result as! Double
                        self.toAmount = toAmount
                        let text = String.formatTo2f(toAmount.round(to: 2)).replacingOccurrences(of: ".", with: ",")
                        self.getView().lowerCurrencyExchangeView.amountTextField.text = text
                    }
                    return nil
                })
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = false
                getView().lowerCurrencyExchangeView.amountTextField.text = nil
            }
        } else {
            toAmount = amount
            if let toAmount = toAmount {
                navigationItem.rightBarButtonItem?.isEnabled = true
                currencyExchangeManager.getFromAmount(toAmount: toAmount, toCurrency: toCurrency, fromCurrency: fromCurrency).continue({ task -> Any? in
                    if let error = task.error {
                        print(error)
                    } else {
                        let fromAmount = task.result as! Double
                        self.fromAmount = fromAmount
                        let text = String.formatTo2f(fromAmount.round(to: 2)).replacingOccurrences(of: ".", with: ",")
                        self.getView().upperCurrencyExchangeView.amountTextField.text = text
                    }
                    return nil
                })
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = false
                getView().upperCurrencyExchangeView.amountTextField.text = nil
            }
        }
    }
    
    func onTextFieldDidBeginEditing(view: UIView) {
        if view.isKind(of: UpperCurrencyExchangeView.self) {
            isUpperTextFieldTriggered = true
        } else {
            isUpperTextFieldTriggered = false
        }
    }
}

// MARK: - AccountSelectionViewControllerDelegate

extension MainViewController: AccountSelectionViewControllerDelegate {
    func onAccountSelected(wallet: Wallet, balance: CurrencyBalance, isCurrencySelectionTriggered: Bool) {
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
        if isCurrencySelectionTriggered {
            upperCurrencySelectionViewController.delegate?.onCurrencySelected(upperCurrencySelectionViewController, balance: balance, isAccountSelectionTriggered: !isCurrencySelectionTriggered)
        }
    }
}

// MARK: - CurrencySelectionViewControllerDelegate

extension MainViewController: CurrencySelectionViewControllerDelegate {
    func onCurrencySelected(_ controller: CurrencySelectionViewController, balance: CurrencyBalance, isAccountSelectionTriggered: Bool) {
        if upperCurrencySelectionViewController == controller {
            if isAccountSelectionTriggered {
                accountSelectionViewController.delegate?.onAccountSelected(wallet: wallet, balance: balance, isCurrencySelectionTriggered: !isAccountSelectionTriggered)
            }
            
            currencyExchangeManager.getToAmount(fromAmount: 1, fromCurrency: balance.currency, toCurrency: lowerCurrencySelectionViewController.currentCurrency!).continue({ task -> Any? in
                if let error = task.error {
                    print(error)
                } else {
                    let toAmount = task.result as! Double
                    let fromCurrencySymbol = NSLocale.getCurrencySymbol(by: balance.currency)!
                    let toCurrencySymbol = NSLocale.getCurrencySymbol(by: self.lowerCurrencySelectionViewController.currentCurrency!)!
                    let text = "1" + fromCurrencySymbol + " = \(toAmount)" + toCurrencySymbol
                    self.getView().upperCurrencyExchangeView.currencyExchangeLabel.text = text
                }
                return nil
            })
            
            currencyExchangeManager.getToAmount(fromAmount: 1, fromCurrency: lowerCurrencySelectionViewController.currentCurrency!, toCurrency: balance.currency).continue({ task -> Any? in
                if let error = task.error {
                    print(error)
                } else {
                    let toAmount = task.result as! Double
                    let fromCurrencySymbol = NSLocale.getCurrencySymbol(by: self.lowerCurrencySelectionViewController.currentCurrency!)!
                    let toCurrencySymbol = NSLocale.getCurrencySymbol(by: balance.currency)!
                    let text = "1" + fromCurrencySymbol + " = \(toAmount)" + toCurrencySymbol
                    self.getView().lowerCurrencyExchangeView.currencyExchangeLabel.text = text
                }
                return nil
            })
        } else {
            lowerCurrencySelectionViewController.currentCurrency = balance.currency

            currencyExchangeManager.getToAmount(fromAmount: 1, fromCurrency: balance.currency, toCurrency: upperCurrencySelectionViewController.currentCurrency!).continue({ task -> Any? in
                if let error = task.error {
                    print(error)
                } else {
                    let toAmount = task.result as! Double
                    let fromCurrencySymbol = NSLocale.getCurrencySymbol(by: balance.currency)!
                    let toCurrencySymbol = NSLocale.getCurrencySymbol(by: self.lowerCurrencySelectionViewController.currentCurrency!)!
                    let text = "1" + fromCurrencySymbol + " = \(toAmount)" + toCurrencySymbol
                    self.getView().lowerCurrencyExchangeView.currencyExchangeLabel.text = text
                }
                return nil
            })
            
            currencyExchangeManager.getToAmount(fromAmount: 1, fromCurrency: upperCurrencySelectionViewController.currentCurrency!, toCurrency: balance.currency).continue({ task -> Any? in
                if let error = task.error {
                    print(error)
                } else {
                    let toAmount = task.result as! Double
                    let fromCurrencySymbol = NSLocale.getCurrencySymbol(by: self.upperCurrencySelectionViewController.currentCurrency!)!
                    let toCurrencySymbol = NSLocale.getCurrencySymbol(by: balance.currency)!
                    let text = "1" + fromCurrencySymbol + " = \(toAmount)" + toCurrencySymbol
                    self.getView().upperCurrencyExchangeView.currencyExchangeLabel.text = text
                }
                return nil
            })
        }
        handleAmountTextField()
        layoutCurrencyExchangeView()
    }
}


