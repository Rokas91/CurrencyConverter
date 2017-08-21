//
//  BaseTableViewCell.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit
import Typhoon

class BaseTableViewCell: UITableViewCell {
    private var isLayoutSubviewed = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
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
