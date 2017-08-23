//
//  Alerting.swift
//  CurrencyConverter
//
//  Created by Rokas on 24/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

protocol Alerting {}

extension Alerting where Self: UIViewController {
    func createAlert(title: String?, message: String?, preferredStyle: UIAlertControllerStyle? = .alert, actions: UIAlertAction...) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle!)
        
        actions.forEach { alertController.addAction($0) }
        present(alertController, animated: true)
    }
}
