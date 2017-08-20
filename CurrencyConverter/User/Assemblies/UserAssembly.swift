//
//  UserAssembly.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Typhoon

class UserAssembly: TyphoonAssembly {
    
    dynamic func userManager() -> AnyObject {
        return TyphoonDefinition.withClass(UserManager.self) { definition in
            definition?.useInitializer(#selector(UserManager.init(userRepository:)), parameters: { initializer in
                initializer?.injectParameter(with: self.userRepository())
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
