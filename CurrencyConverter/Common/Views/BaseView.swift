//
//  BaseView.swift
//  CurrencyConverter
//
//  Created by Rokas on 18/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit
import Typhoon

protocol BaseViewDelegate: class {}

class BaseView: UIView {
    weak var delegate: BaseViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        (TyphoonComponentFactory.defaultFactory() as AnyObject).inject(self)
        render()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func render() {
        backgroundColor = .customGreen
    }
    
    func getDelegate() -> BaseViewDelegate? {
        return delegate
    }
}
