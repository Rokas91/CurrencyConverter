//
//  UIFont+ext.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

extension UIFont {
    
    class var avenir: UIFont {
        return UIFont(name: "Avenir-Book", size: 17)!
    }
    
    class func avenir(size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Book", size: size)!
    }
    
}
