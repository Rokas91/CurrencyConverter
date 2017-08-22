//
//  CurrencySelectionView.swift
//  CurrencyConverter
//
//  Created by Rokas on 21/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

protocol CurrencySelectionViewDelegate: BaseViewDelegate {
    func onCurrencySelected(balance: CurrencyBalance)
}

class CurrencySelectionView: BaseView {
    lazy var currencySelectionTableView: CurrencySelectionTableView = {
        let currencySelectionTableView = CurrencySelectionTableView()
        currencySelectionTableView.translatesAutoresizingMaskIntoConstraints = false
        currencySelectionTableView.baseTableViewDelegate = self
        currencySelectionTableView.layer.cornerRadius = 10
        currencySelectionTableView.layer.masksToBounds = true
        return currencySelectionTableView
    }()
    
    func getDelegate() -> CurrencySelectionViewDelegate? {
        return delegate as? CurrencySelectionViewDelegate
    }
}

// MARK: - Layout

extension CurrencySelectionView {
    override func render() {
        super.render()
        
        layoutAccountSelectionTableView()
    }
    
    private func layoutAccountSelectionTableView() {
        addSubview(currencySelectionTableView)
        
        currencySelectionTableView.topAnchor.constraint(equalTo: topAnchor, constant: 70).isActive = true
        currencySelectionTableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        currencySelectionTableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        currencySelectionTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
}

// MARK: - CurrencySelectionTableViewDelegate

extension CurrencySelectionView: CurrencySelectionTableViewDelegate {
    func onCurrencySelected(balance: CurrencyBalance) {
        getDelegate()?.onCurrencySelected(balance: balance)
    }
}
