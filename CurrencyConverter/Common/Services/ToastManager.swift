//
//  ToastManager.swift
//  CurrencyConverter
//
//  Created by Rokas on 23/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import CRToast

class ToastManager: NSObject {
    func showSuccessNotification() {
        hideToast()
        let options = buildOptions(title: SUCCESS_MESSAGE, color: UIColor(2, 126, 103), image: UIImage(named: "toastSuccess")!)
        CRToastManager.showNotification(options: options) {}
    }
    func showErrorNotification(with title: String) {
        hideToast()
        let options = buildOptions(title: title, color: UIColor(201, 3, 42), image: UIImage(named: "toastError")!)
        CRToastManager.showNotification(options: options) {}
    }

    private func hideToast() {
        CRToastManager.dismissNotification(true)
    }
    
    private func buildOptions(title: String, color: UIColor, image: UIImage) -> [AnyHashable: Any] {
        var options = [AnyHashable: Any]()
        options[kCRToastTextKey] = title
        options[kCRToastBackgroundColorKey] = color
        options[kCRToastImageKey] = image
        options[kCRToastTimeIntervalKey] = NSNumber(value: 5)
        options[kCRToastNotificationTypeKey] = NSNumber(value: CRToastType.custom.rawValue)
        options[kCRToastNotificationPreferredHeightKey] = NSNumber(value: 60)
        options[kCRToastTextColorKey] = UIColor.white
        options[kCRToastFontKey] = UIFont.avenir(size: 17)
        return options
    }
}
