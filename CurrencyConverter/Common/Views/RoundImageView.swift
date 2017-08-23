//
//  RoundImageView.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    private var isLayoutSubviewed = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isLayoutSubviewed {
            layer.cornerRadius = frame.height / 2
            clipsToBounds = true
            layer.borderWidth = 0.5
            layer.borderColor = UIColor.gray.cgColor
            
            layer.shadowColor = UIColor.gray.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 1)
            layer.shadowOpacity = 1
            layer.shadowRadius = 1.0
            
            isLayoutSubviewed = true
        }
    }
    
    func setFlag(with currencyCode: String) {
        guard let flagIdentifier = NSLocale.getCountryCode(by: currencyCode) else {
            print("flagIdentifier was not found by currencyCode \(currencyCode)")
            return
        }
        image = UIImage(named: "flag_\(flagIdentifier)")
    }
}
