//
//  BaseTableView.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

protocol BaseTableViewDelegate: class {
}

class BaseTableView: UITableView {
    weak var baseTableViewDelegate: BaseTableViewDelegate?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        onTableViewInitialized()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onTableViewInitialized() {
    }
}

