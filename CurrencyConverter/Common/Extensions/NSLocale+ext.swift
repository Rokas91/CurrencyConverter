//
//  NSLocale+ext.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Foundation

extension NSLocale {
    class func getCountryCode(by currencyCode: String) -> String? {
        switch currencyCode {
        case "EUR":
            return "eu"
        case "AUD":
            return "au"
        case "DKK":
            return "dk"
        case "NZD":
            return "nz"
        case "BYN":
            return "by"
        case "USD":
            return "us"
        case "GBP":
            return "gb"
        default:
            return (findLocale(by: currencyCode)?.object(forKey: NSLocale.Key.countryCode) as? String)?.lowercased()
        }
    }
    
    class func getCurrencyName(by currencyCode: String) -> String? {
        let locale = NSLocale(localeIdentifier: "lt")
        return locale.displayName(forKey: NSLocale.Key.currencyCode, value: currencyCode)
    }
    
    class func getCurrencySymbol(by currencyCode: String) -> String? {
        let locale = findLocale(by: currencyCode)
        if let locale = locale {
            return (locale.displayName(forKey: NSLocale.Key.currencySymbol, value: currencyCode) != nil) ? locale.displayName(forKey: NSLocale.Key.currencySymbol, value: currencyCode)! : currencyCode
        } else {
            return nil
        }
    }
    
    private class func findLocale(by currencyCode: String) -> NSLocale? {
        for identifier in NSLocale.availableLocaleIdentifiers {
            let locale = NSLocale(localeIdentifier: identifier)
            if let localeCurrencyCode = locale.object(forKey: NSLocale.Key.currencyCode) {
                if (localeCurrencyCode as! String) == currencyCode {
                    return locale
                }
            }
        }
        return nil
    }
}
