//
//  SelectionTableViewHeaderCell.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class SelectionTableViewHeaderCell: BaseTableViewHeaderCell {
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.textColor = .white
        label.font = UIFont.avenir(size: 20)
        return label
    }()

    var wallet: Wallet! {
        didSet{
            configure(with: wallet)
        }
    }
    
    private func configure(with wallet: Wallet) {
        titleLabel.text = wallet.accountNumber
    }
}

// MARK: - Layout

extension SelectionTableViewHeaderCell {
    override func render() {
        layoutTitleLabel()
        backgroundView = UIView()
    }
    
    private func layoutTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
