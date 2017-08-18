//
//  MainAssembly.swift
//  CurrencyConverter
//
//  Created by Rokas on 18/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit
import Typhoon

class MainAssembly: TyphoonAssembly {
    dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self) { definition in
            definition?.injectProperty(#selector(self.mainViewController))
            } as AnyObject
    }
    
    dynamic func mainViewController() -> AnyObject {
        return TyphoonDefinition.withClass(MainViewController.self) { definition in
            definition?.scope = TyphoonScope.prototype
            } as AnyObject
    }
}
