//
//  ApplicationAssembly.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Typhoon

class ApplicationAssembly: TyphoonAssembly {
    var mainAssembly: MainAssembly!
    
    dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self) { definition in
            definition?.injectProperty(#selector(self.mainAssembly.mainViewController))
            definition?.injectProperty(Selector(("applicationAssembly")), with: self)
            } as AnyObject
    }
    
    dynamic func realmDataFixture() -> AnyObject {
        return TyphoonDefinition.withClass(RealmDataFixture.self) { definition in
            definition?.scope = TyphoonScope.singleton
            } as AnyObject
    }
}
