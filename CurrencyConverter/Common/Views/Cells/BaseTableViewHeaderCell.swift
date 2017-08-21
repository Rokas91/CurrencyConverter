//
//  BaseTableViewHeaderCell.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit
import Typhoon

class BaseTableViewHeaderCell: UITableViewHeaderFooterView {
    private var isLayoutSubviewed = false
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        (TyphoonComponentFactory.defaultFactory() as AnyObject).inject(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isLayoutSubviewed {
            render()
        }
    }
    
    dynamic func render() {}
}
