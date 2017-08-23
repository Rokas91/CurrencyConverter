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
    var userAssembly: UserAssembly!
    
    dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self) { definition in
            definition?.injectProperty(#selector(self.mainAssembly.mainViewController))
            definition?.injectProperty(Selector(("applicationAssembly")), with: self)
            } as AnyObject
    }
    
    dynamic func applicationUpdateNotifierListener() -> AnyObject {
        return TyphoonDefinition.withClass(ApplicationUpdateNotifierListener.self) { definition in
            definition?.injectProperty(#selector(self.userAssembly.userManager))
            definition?.injectProperty(#selector(self.realmDataFixture))
            definition?.injectProperty(#selector(self.currencyManager))
            definition?.scope = TyphoonScope.singleton
            } as AnyObject
    }
    
    dynamic func realmDataFixture() -> AnyObject {
        return TyphoonDefinition.withClass(RealmDataFixture.self) { definition in
            definition?.useInitializer(#selector(RealmDataFixture.init(currencyManager:)), parameters: { initializer in
                initializer?.injectParameter(with: self.currencyManager())
            })
            definition?.scope = TyphoonScope.singleton
            } as AnyObject
    }
    
    dynamic func currencyAPIClient() -> AnyObject {
        return TyphoonDefinition.withClass(CurrencyAPIClient.self) { definition in
            definition?.useInitializer(#selector(CurrencyAPIClient.init(baseUrl:)), parameters: { initializer in
                initializer?.injectParameter(with: BASE_URL)
            })
            definition?.scope = TyphoonScope.singleton
            } as AnyObject
    }
    
    dynamic func currencyManager() -> AnyObject {
        return TyphoonDefinition.withClass(CurrencyManager.self) { definition in
            definition?.useInitializer(#selector(CurrencyManager.init(currencyAPIClient:)), parameters: { initializer in
                initializer?.injectParameter(with: self.currencyAPIClient())
            })
            definition?.scope = TyphoonScope.singleton
            } as AnyObject
    }
    
    dynamic func currencyExchangeManager() -> AnyObject {
        return TyphoonDefinition.withClass(CurrencyExchangeManager.self) { definition in
            definition?.useInitializer(#selector(CurrencyExchangeManager.init(currencyAPIClient:toastManager:)), parameters: { initializer in
                initializer?.injectParameter(with: self.currencyAPIClient())
                initializer?.injectParameter(with: self.toastManager())
            })
            definition?.scope = TyphoonScope.singleton
            } as AnyObject
    }
    
    dynamic func toastManager() -> AnyObject {
        return TyphoonDefinition.withClass(ToastManager.self) { definition in
            definition?.scope = TyphoonScope.singleton
            } as AnyObject
    }
}
