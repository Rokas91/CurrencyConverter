//
//  BaseViewController.swift
//  CurrencyConverter
//
//  Created by Rokas on 18/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
//        edgesForExtendedLayout = UIRectEdge()
//        let backImage = UIImage(named: "backButton")?.resizableImage(withCapInsets: UIEdgeInsetsMake(1, 14, 1, 1))
//        navigationItem.backBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(onBackTapped))
    }
    
    override func loadView() {
        view = createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createView() -> UIView {
        let viewName = String(describing: self.classForCoder).replacingOccurrences(of: "Controller", with: "")
        let object = NSStringFromClass(BaseViewController.self) as NSString
        let module = object.components(separatedBy: ".").first!
        let className = "\(module).\(viewName)"
        let classFromName = NSClassFromString(className) as! UIView.Type
        return classFromName.init(frame: getFrame())
    }
    
    func getView() -> UIView {
        return view
    }
    
    func getFrame() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func onBackTapped() {
        dismiss(animated: true)
    }
}
