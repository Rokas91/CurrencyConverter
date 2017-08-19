//
//  UserAssembly.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Typhoon

class UserAssembly: TyphoonAssembly {
    var walletAssembly: WalletAssembly!
    
    dynamic func userManager() -> AnyObject {
        return TyphoonDefinition.withClass(UserManager.self) { definition in
            definition?.useInitializer(#selector(UserManager.init(userRepository:walletManager:)), parameters: { initializer in
                initializer?.injectParameter(with: self.userRepository())
                initializer?.injectParameter(with: (self.walletAssembly.walletManager()))
            })
            
            definition?.scope = TyphoonScope.singleton
            } as AnyObject
    }
    
    dynamic func userRepository() -> AnyObject {
        return TyphoonDefinition.withClass(UserRepository.self) { definition in
            definition!.scope = TyphoonScope.singleton
            } as AnyObject
    }
}
