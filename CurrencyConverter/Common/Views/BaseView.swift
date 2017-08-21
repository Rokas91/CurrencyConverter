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
    private var isLayoutSubviewed = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        (TyphoonComponentFactory.defaultFactory() as AnyObject).inject(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isLayoutSubviewed {
            render()
            isLayoutSubviewed = true
        }
    }
    
    dynamic func render() {
        backgroundColor = .customGreen
    }
}
