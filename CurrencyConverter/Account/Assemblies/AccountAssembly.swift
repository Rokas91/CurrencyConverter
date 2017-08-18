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
    dynamic func accountViewController() -> AnyObject {
        return TyphoonDefinition.withClass(AccountViewController.self) { definition in
            definition?.scope = TyphoonScope.prototype
            } as AnyObject
    }
}
