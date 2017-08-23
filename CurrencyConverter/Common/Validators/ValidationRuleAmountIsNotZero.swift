//
//  ValidationRuleAmountIsNotZero.swift
//  CurrencyConverter
//
//  Created by Rokas on 22/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Validator

struct ValidationRuleAmountIsNotZero: ValidationRule {
    var error: Error
    typealias InputType = Money
    
    init() {
        error = ValidationError("validation_amount_is_zero")
    }
    
    func validate(input: Money?) -> Bool {
        guard let input = input else {
            return false
        }
        return !input.isZero()
    }
}
