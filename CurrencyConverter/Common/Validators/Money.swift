//
//  Money.swift
//  CurrencyConverter
//
//  Created by Rokas on 22/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Foundation

struct Money {
    private var amount: Double = 0
    private var fromAmount: Double = 0
    private var atDisposal: Double = 0
    
    init(amount: Double) {
        self.amount = amount
    }
    
    init(fromAmount: Double, atDisposal: Double) {
        self.fromAmount = fromAmount
        self.atDisposal = atDisposal
    }
    
    func isZero() -> Bool {
        return amount.round(to: 2) == 0
    }
    
    func isFromAmountGreaterThanDisposal() -> Bool {
        return fromAmount > atDisposal
    }
}
