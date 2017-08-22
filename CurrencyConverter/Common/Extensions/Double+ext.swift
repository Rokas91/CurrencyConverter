//
//  Double+ext.swift
//  CurrencyConverter
//
//  Created by Rokas on 22/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Foundation

extension Double {
    static func random(lower: Double, upper: Double) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
    
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}
