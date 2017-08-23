//
//  CurrencyExchangeView.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class UpperCurrencyExchangeView: CurrencyExchangeView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        amountTextField.textColor = .yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LowerCurrencyExchangeView: CurrencyExchangeView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        amountTextField.textColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol CurrencyExchangeViewDelegate: class {
    func onCurrencyExchangeButtonTapped(view: UIView)
    func onTextFieldDidChange(view: UIView, amount: Double?)
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
        label.font = .avenir
        return label
    }()
    
    lazy var currencyExchangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.avenir(size: 15)
        label.textAlignment = .right
        return label
    }()
    
    lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        textField.textAlignment = .right
        textField.font = .avenir
        return textField
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private dynamic func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            let formatter = NumberFormatter()
            if let number = formatter.number(from: text) {
                delegate?.onTextFieldDidChange(view: self, amount: Double(number))
            }
        } else {
            delegate?.onTextFieldDidChange(view: self, amount: nil)
        }
    }
}

// MARK: - Layout

extension CurrencyExchangeView {
    fileprivate func layout() {
        layoutFlagImageView()
        layoutCurrencyLabel()
        layoutDownArrowImageView()
        layoutButton()
        layoutAmountTextField()
        layoutCurrencyExchangeLabel()
    }
    
    private func layoutFlagImageView() {
        addSubview(flagImageView)
        
        flagImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        flagImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        flagImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        flagImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func layoutCurrencyLabel() {
        addSubview(currencyLabel)
        
        currencyLabel.leftAnchor.constraint(equalTo: flagImageView.rightAnchor, constant: 5).isActive = true
        currencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func layoutDownArrowImageView() {
        addSubview(downArrowImageView)
        
        downArrowImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        downArrowImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        downArrowImageView.leftAnchor.constraint(equalTo: currencyLabel.rightAnchor, constant: 5).isActive = true
        downArrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func layoutButton() {
        addSubview(button)
        
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: flagImageView.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: downArrowImageView.rightAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func layoutAmountTextField() {
        addSubview(amountTextField)
        
        amountTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        amountTextField.leftAnchor.constraint(equalTo: button.rightAnchor).isActive = true
        amountTextField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func layoutCurrencyExchangeLabel() {
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





























