//
//  SelectionTableViewCell.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class SelectionTableViewCell: BaseTableViewCell {
    lazy var transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var flagImageView: RoundImageView = {
        let imageView = RoundImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.textColor = .customGreen
        label.font = UIFont.avenir(size: 17)
        return label
    }()
    
    fileprivate lazy var currencyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.textColor = .darkGray
        label.font = UIFont.avenir(size: 12)
        return label
    }()
    
    fileprivate lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    fileprivate lazy var amountSymbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    var currencyBalance: CurrencyBalance! {
        didSet{
            configure(with: currencyBalance)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight, .bottomRight, .bottomLeft], cornerRadii: CGSize(width: 0, height: 0)).cgPath
        layer.mask = shapeLayer
        transparentView.backgroundColor = UIColor(white: 1, alpha: 0.7)
    }
    
    private func configure(with currencyBalance: CurrencyBalance) {
        flagImageView.setFlag(with: currencyBalance.currency)
        currencyLabel.text = currencyBalance.currency
        currencyDescriptionLabel.text = NSLocale.getCurrencyName(by: currencyBalance.currency)
        amountLabel.text = String.formatTo2f(currencyBalance.atDisposal)
        amountSymbolLabel.text = NSLocale.getCurrencySymbol(by: currencyBalance.currency)
    }
}

// MARK: - Layout

extension SelectionTableViewCell {
    override func render() {
        layoutFlagImageView()
        layoutCurrencyLabel()
        layoutCurrencyDescriptionLabel()
        layoutAmountSymbolLabel()
        layoutAmountLabel()
        layoutTransparentView()
    }
    
    private func layoutFlagImageView() {
        addSubview(flagImageView)
        
        flagImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        flagImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        flagImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        flagImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func layoutCurrencyLabel() {
        addSubview(currencyLabel)
        
        currencyLabel.leftAnchor.constraint(equalTo: flagImageView.rightAnchor, constant: 5).isActive = true
        currencyLabel.topAnchor.constraint(equalTo: flagImageView.topAnchor, constant: -3).isActive = true
    }
    
    private func layoutCurrencyDescriptionLabel() {
        addSubview(currencyDescriptionLabel)
        
        currencyDescriptionLabel.leftAnchor.constraint(equalTo: currencyLabel.leftAnchor).isActive = true
        currencyDescriptionLabel.bottomAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 3).isActive = true
    }
    
    private func layoutAmountSymbolLabel() {
        addSubview(amountSymbolLabel)
        
        amountSymbolLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        amountSymbolLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    private func layoutAmountLabel() {
        addSubview(amountLabel)
        
        amountLabel.rightAnchor.constraint(equalTo: amountSymbolLabel.leftAnchor).isActive = true
        amountLabel.bottomAnchor.constraint(equalTo: amountSymbolLabel.bottomAnchor).isActive = true
    }

    private func layoutTransparentView() {
        addSubview(transparentView)
        
        transparentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        transparentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        transparentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        transparentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}































