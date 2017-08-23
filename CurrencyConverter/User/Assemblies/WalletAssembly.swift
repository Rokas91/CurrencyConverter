//
//  WalletAssembly.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Typhoon

class WalletAssembly: TyphoonAssembly {
    
    dynamic func walletManager() -> AnyObject {
        return TyphoonDefinition.withClass(WalletManager.self) { definition in
            definition?.useInitializer(#selector(WalletManager.init(walletRepository:)), parameters: { initializer in
                initializer?.injectParameter(with: self.walletRepository())
            })
            definition?.scope = TyphoonScope.singleton
            } as AnyObject
    }
    
    dynamic func walletRepository() -> AnyObject {
        return TyphoonDefinition.withClass(WalletRepository.self) { definition in
            definition!.scope = TyphoonScope.singleton
            } as AnyObject
    }
}
