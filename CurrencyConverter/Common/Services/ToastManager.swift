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
        let options = buildOptions(title: SUCCESS_MESSAGE, color: UIColor(2, 126, 103), image: UIImage(named: "toastSuccess")!, duration: 5)
        CRToastManager.showNotification(options: options) {}
    }
    
    func showErrorNotification(with title: String) {
        hideToast()
        let options = buildOptions(title: title, color: UIColor(201, 3, 42), image: UIImage(named: "toastError")!, duration: 10)
        CRToastManager.showNotification(options: options) {}
    }

    private func hideToast() {
        CRToastManager.dismissNotification(true)
    }
    
    private func buildOptions(title: String, color: UIColor, image: UIImage, duration: NSNumber) -> [AnyHashable: Any] {
        let interactionResponder = CRToastInteractionResponder(interactionType: .all, automaticallyDismiss: true) { type in
            self.hideToast()
        }
        
        var options = [AnyHashable: Any]()
        options[kCRToastTextKey] = title
        options[kCRToastBackgroundColorKey] = color
        options[kCRToastImageKey] = image
        options[kCRToastTimeIntervalKey] = duration
        options[kCRToastNotificationTypeKey] = NSNumber(value: CRToastType.custom.rawValue)
        options[kCRToastNotificationPreferredHeightKey] = NSNumber(value: 60)
        options[kCRToastTextColorKey] = UIColor.white
        options[kCRToastFontKey] = UIFont.avenir(size: 17)
        options[kCRToastInteractionRespondersKey] = [interactionResponder!]
        return options
    }
}
