//
//  AccountAssembly.swift
//  CurrencyConverter
//
//  Created by Rokas on 18/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit
import Typhoon

class AccountAssembly: TyphoonAssembly {
    var walletAssembly: WalletAssembly!
    
    dynamic func accountSelectionViewController() -> AnyObject {
        return TyphoonDefinition.withClass(AccountSelectionViewController.self) { definition in
            definition?.useInitializer(#selector(AccountSelectionViewController.init(accountSelectionTableViewController:)), parameters: { initializer in
                initializer?.injectParameter(with: self.accountSelectionTableViewController())
            })
            definition?.scope = TyphoonScope.prototype
            } as AnyObject
    }
    
    dynamic func accountSelectionTableViewController() -> AnyObject {
        return TyphoonDefinition.withClass(AccountSelectionTableViewController.self) { definition in
            definition?.scope = TyphoonScope.prototype
            } as AnyObject
    }
    
    dynamic func upperCurrencySelectionViewController() -> AnyObject {
        return TyphoonDefinition.withClass(UpperCurrencySelectionViewController.self) { definition in
            definition?.useInitializer(#selector(UpperCurrencySelectionViewController.init(currencySelectionTableViewController:)), parameters: { initializer in
                initializer?.injectParameter(with: self.currencySelectionTableViewController())
            })
            definition?.scope = TyphoonScope.prototype
            } as AnyObject
    }
    
    dynamic func lowerCurrencySelectionViewController() -> AnyObject {
        return TyphoonDefinition.withClass(LowerCurrencySelectionViewController.self) { definition in
            definition?.useInitializer(#selector(LowerCurrencySelectionViewController.init(currencySelectionTableViewController:)), parameters: { initializer in
                initializer?.injectParameter(with: self.currencySelectionTableViewController())
            })
            definition?.scope = TyphoonScope.prototype
            } as AnyObject
    }
    
    dynamic func currencySelectionTableViewController() -> AnyObject {
        return TyphoonDefinition.withClass(CurrencySelectionTableViewController.self) { definition in
            definition?.scope = TyphoonScope.prototype
            } as AnyObject
    }
}
