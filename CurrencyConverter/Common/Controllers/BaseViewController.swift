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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = createView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        makeNavigationBarTransparent()
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
