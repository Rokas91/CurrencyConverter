//
//  CurrencyAPIClient.swift
//  CurrencyConverter
//
//  Created by Rokas on 22/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import Alamofire
import Bolts

class CurrencyAPIClient: NSObject {
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
        super.init()
    }
    
    func fetchCurrencyRates(baseCurrency: String) -> BFTask<AnyObject> {
        let taskCompletionSource = BFTaskCompletionSource<AnyObject>()
        
        Alamofire.request(baseUrl + baseCurrency, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = response.result.value as! Dictionary<String, Any>
                    taskCompletionSource.setResult(json["rates"] as AnyObject)
                case .failure(let error):
                    taskCompletionSource.setError(error)
                }
        }
        return taskCompletionSource.task
    }
    
    func getAvailableCurrencies() -> BFTask<AnyObject> {
        return fetchCurrencyRates(baseCurrency: "EUR").continue({ task -> Any? in
            let taskCompletionSource = BFTaskCompletionSource<AnyObject>()
            if let error = task.error {
                taskCompletionSource.setError(error)
            } else {
                let rates = task.result as! Dictionary<String, Any>
                var currencies = Array(rates.keys)
                currencies.append("EUR")
                taskCompletionSource.setResult(currencies as AnyObject)
            }
            return taskCompletionSource.task
        })
    }
}
