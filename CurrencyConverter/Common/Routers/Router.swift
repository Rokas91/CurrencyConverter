//
//  Router.swift
//  CurrencyConverter
//
//  Created by Rokas on 19/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class Router: NSObject {
    func goToViewControllerInNavigationViewController(_ controller: UIViewController) {
        UIViewController.topmost().presentViewControllerInNavigationViewController(controller)
    }
}
