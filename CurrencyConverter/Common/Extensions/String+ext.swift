//
//  String+ext.swift
//  CurrencyConverter
//
//  Created by Rokas on 22/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Foundation

extension String {
    static func formatTo2f(_ number: Double) -> String {
        return String(format: "%.2f", number)
    }
}
