//
//  Router.swift
//  CurrencyConverter
//
//  Created by Rokas on 18/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class Router: NSObject {
    func goToViewController(_ controller: UIViewController) {
        UIViewController.topmost().present(controller, animated: true, completion: nil)
    }
}
