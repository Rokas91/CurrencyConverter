//
//  AccountSelectionView.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

protocol AccountSelectionViewDelegate: BaseViewDelegate {
    func onAccountSelected(wallet: Wallet, balance: CurrencyBalance)
}

class AccountSelectionView: BaseView {
    fileprivate let topMargin: CGFloat = 30
    fileprivate let bottomMargin: CGFloat = 20
    
    lazy var accountSelectionTableView: AccountSelectionTableView = {
        let accountSelectionTableView = AccountSelectionTableView()
        accountSelectionTableView.translatesAutoresizingMaskIntoConstraints = false
        accountSelectionTableView.baseTableViewDelegate = self
        accountSelectionTableView.layer.cornerRadius = 10
        accountSelectionTableView.layer.masksToBounds = true
        return accountSelectionTableView
    }()
    
    fileprivate lazy var blurBackground: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()
    
    fileprivate lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customGreen
        return view
    }()
    
    func getDelegate() -> AccountSelectionViewDelegate? {
        return delegate as? AccountSelectionViewDelegate
    }
}

// MARK: - Layout

extension AccountSelectionView {
    override func onViewDidLoad() {
        layoutBlurBackground()
        layoutBackgroundView()
        layoutAccountSelectionTableView()
    }
    
    private func layoutBlurBackground() {
        addSubview(blurBackground)
        
        blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurBackground.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        blurBackground.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func layoutBackgroundView() {
        addSubview(backgroundView)
        let height = accountSelectionTableView.contentSize.height + topMargin + bottomMargin
        
        backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        if height < frame.height {
            backgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        } else {
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
    
    private func layoutAccountSelectionTableView() {
        backgroundView.addSubview(accountSelectionTableView)
        
        accountSelectionTableView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: topMargin).isActive = true
        accountSelectionTableView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 20).isActive = true
        accountSelectionTableView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -20).isActive = true
        accountSelectionTableView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -bottomMargin).isActive = true
    }
}

// MARK: - Selectors

extension AccountSelectionView {
    fileprivate dynamic func dismiss() {
        UIViewController.topmost().dismiss(animated: true)
    }
}

// MARK: - AccountSelectionTableViewDelegate

extension AccountSelectionView: AccountSelectionTableViewDelegate {
    func onAccountSelected(wallet: Wallet, balance: CurrencyBalance) {
        getDelegate()?.onAccountSelected(wallet: wallet, balance: balance)
    }
}















