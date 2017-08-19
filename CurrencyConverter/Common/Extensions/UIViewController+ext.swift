//
//  UIViewController+ext.swift
//  CurrencyConverter
//
//  Created by Rokas on 18/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

extension UIViewController {
    class func topmost() -> UIViewController {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while let presentedViewController = topController?.presentedViewController {
            topController = presentedViewController
        }
        return topController!
    }
    
    func presentViewControllerInNavigationViewController(_ controller: UIViewController, 
                                                         modalPresentationStyle: UIModalPresentationStyle? = nil, 
                                                         modalTransitionStyle: UIModalTransitionStyle? = nil,
                                                         completion: @escaping (() -> ()) = {}) {
        let controller = UINavigationController(rootViewController: controller)
        if let modalPresentationStyle = modalPresentationStyle {
            controller.modalPresentationStyle = modalPresentationStyle
        }
        if let modalTransitionStyle = modalTransitionStyle {
            controller.modalTransitionStyle = modalTransitionStyle
        }
        present(
            controller,
            animated: true,
            completion: {
                completion()
        })
    }
    
    func makeNavigationBarTransparent() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
}


