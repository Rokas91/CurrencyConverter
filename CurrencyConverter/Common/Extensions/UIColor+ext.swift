//
//  UIColor+ext.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

extension UIColor {
    class var customLightGreen: UIColor {
        return UIColor(224, 242, 241)
    }
    
    class var customGreen: UIColor {
        return UIColor(38, 166, 154)
    }
    
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
