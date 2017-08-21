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
}
