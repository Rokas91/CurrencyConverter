//
//  CurrencyExchangeView.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class UpperCurrencyExchangeView: CurrencyExchangeView {
}

class LowerCurrencyExchangeView: CurrencyExchangeView {
}

protocol CurrencyExchangeViewDelegate: class {
    func onCurrencyExchangeButtonTapped(view: UIView)
}

class CurrencyExchangeView: UIView {
    weak var delegate: CurrencyExchangeViewDelegate?
    
    lazy var flagImageView: RoundImageView = {
        let imageView = RoundImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.textColor = .white
        return label
    }()
    
    fileprivate lazy var downArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "downArrow")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var amountTextField: UITextField = {
        let textField = UITextField()
//        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        textField.textAlignment = .right
        return textField
    }()
    
    fileprivate lazy var currencyExchangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Currency exchange"
        label.font = UIFont.avenir(size: 15)
        label.textAlignment = .right
        return label
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

extension CurrencyExchangeView {
    fileprivate func setupLayout() {
        setupFlagImageView()
        setupCurrencyLabel()
        setupDownArrowImageView()
        setupButton()
        setupAmountTextField()
        setupCurrencyExchangeLabel()
    }
    
    private func setupFlagImageView() {
        addSubview(flagImageView)
        
        flagImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        flagImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        flagImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        flagImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupCurrencyLabel() {
        addSubview(currencyLabel)
        
        currencyLabel.leftAnchor.constraint(equalTo: flagImageView.rightAnchor, constant: 5).isActive = true
        currencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupDownArrowImageView() {
        addSubview(downArrowImageView)
        
        downArrowImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        downArrowImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        downArrowImageView.leftAnchor.constraint(equalTo: currencyLabel.rightAnchor, constant: 5).isActive = true
        downArrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupButton() {
        addSubview(button)
        
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: flagImageView.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: downArrowImageView.rightAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupAmountTextField() {
        addSubview(amountTextField)
        
        amountTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        amountTextField.leftAnchor.constraint(equalTo: button.rightAnchor).isActive = true
        amountTextField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupCurrencyExchangeLabel() {
        addSubview(currencyExchangeLabel)
        
        currencyExchangeLabel.topAnchor.constraint(equalTo: amountTextField.bottomAnchor).isActive = true
        currencyExchangeLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        currencyExchangeLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        currencyExchangeLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

// MARK: - Selectors

extension CurrencyExchangeView {
    fileprivate dynamic func buttonTapped() {
        delegate?.onCurrencyExchangeButtonTapped(view: self)
    }
}





























