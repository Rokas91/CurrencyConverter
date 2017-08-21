//
//  AccountView.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

protocol AccountViewDelegate: class {
    func onAccountButtonTapped()
}

class AccountView: UIView {
    weak var delegate: AccountViewDelegate?
    
    lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.text = "Account name"
        label.textColor = .white
        return label
    }()
    
    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.textColor = .white
        return label
    }()
    
    fileprivate lazy var forwardArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "forwardArrow")
        
        return imageView
    }()
    
    fileprivate lazy var accountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Layout

extension AccountView {
    fileprivate func setupLayout() {
        setupAccountLabel()
        setupBalanceLabel()
        setupForwardArrowImageView()
        setupAccountButton()
    }
    
    private func setupAccountLabel() {
        addSubview(accountLabel)
        
        accountLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        accountLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    private func setupBalanceLabel() {
        addSubview(balanceLabel)
        
        balanceLabel.leftAnchor.constraint(equalTo: accountLabel.leftAnchor).isActive = true
        balanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupForwardArrowImageView() {
        addSubview(forwardArrowImageView)
        
        forwardArrowImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        forwardArrowImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        forwardArrowImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        forwardArrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupAccountButton() {
        addSubview(accountButton)
        
        accountButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        accountButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        accountButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        accountButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

// MARK: - Selectors

extension AccountView {
    fileprivate dynamic func accountButtonTapped() {
        delegate?.onAccountButtonTapped()
    }
}

