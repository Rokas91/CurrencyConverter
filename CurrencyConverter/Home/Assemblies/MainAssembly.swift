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
    var userAssembly: UserAssembly!
    var applicationAssembly: ApplicationAssembly!
    
    dynamic func mainViewController() -> AnyObject {
        return TyphoonDefinition.withClass(MainViewController.self) { definition in
            definition?.injectProperty(#selector(self.userAssembly.userManager))
            definition?.injectProperty(#selector(self.applicationAssembly.realmDataFixture))
            definition?.scope = TyphoonScope.prototype
            } as AnyObject
    }
}
