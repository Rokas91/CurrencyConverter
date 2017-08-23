//
//  ValidationError.swift
//  CurrencyConverter
//
//  Created by Rokas on 22/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Foundation

struct ValidationError: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
}
