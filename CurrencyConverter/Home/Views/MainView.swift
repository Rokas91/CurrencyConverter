//
//  MainView.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class MainView: BaseView {
    lazy var accountView: AccountView = {
        let view = AccountView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var upperCurrencyExchangeView: CurrencyExchangeView = {
        let view = CurrencyExchangeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lowerCurrencyExchangeView: CurrencyExchangeView = {
        let view = CurrencyExchangeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func render() {
        super.render()
        
        setupLayout()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(2.0)
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.move(to: CGPoint(x: 10, y: accountView.frame.maxY + 90))
        context?.addLine(to: CGPoint(x: frame.size.width / 2 - 20, y: accountView.frame.maxY + 90))
        context?.addLine(to: CGPoint(x: frame.size.width / 2, y: accountView.frame.maxY + 110))
        context?.addLine(to: CGPoint(x: frame.size.width / 2 + 20, y: accountView.frame.maxY + 90))
        context?.addLine(to: CGPoint(x: frame.size.width - 10, y: accountView.frame.maxY + 90))
        context?.strokePath()
    }
}

// MARK: - Layout

extension MainView {
    fileprivate func setupLayout() {
        setupAccountView()
        setupUpperCurrencyExchangeView()
        setupLowerCurrencyExchangeView()
    }
    
    private func setupAccountView() {
        addSubview(accountView)
        
        accountView.topAnchor.constraint(equalTo: topAnchor, constant: 70).isActive = true
        accountView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        accountView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        accountView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupUpperCurrencyExchangeView() {
        addSubview(upperCurrencyExchangeView)
        
        upperCurrencyExchangeView.topAnchor.constraint(equalTo: accountView.bottomAnchor, constant: 35).isActive = true
        upperCurrencyExchangeView.leftAnchor.constraint(equalTo: accountView.leftAnchor).isActive = true
        upperCurrencyExchangeView.rightAnchor.constraint(equalTo: accountView.rightAnchor).isActive = true
        upperCurrencyExchangeView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupLowerCurrencyExchangeView() {
        addSubview(lowerCurrencyExchangeView)
        
        lowerCurrencyExchangeView.topAnchor.constraint(equalTo: upperCurrencyExchangeView.bottomAnchor, constant: 10).isActive = true
        lowerCurrencyExchangeView.leftAnchor.constraint(equalTo: upperCurrencyExchangeView.leftAnchor).isActive = true
        lowerCurrencyExchangeView.rightAnchor.constraint(equalTo: upperCurrencyExchangeView.rightAnchor).isActive = true
        lowerCurrencyExchangeView.heightAnchor.constraint(equalTo: upperCurrencyExchangeView.heightAnchor).isActive = true
    }
}
































