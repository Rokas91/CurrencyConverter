//
//  CurrencySelectionTableView.swift
//  CurrencyConverter
//
//  Created by Rokas on 21/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

protocol CurrencySelectionTableViewDelegate: BaseTableViewDelegate {
    func onCurrencySelected(balance: CurrencyBalance)
}

class CurrencySelectionTableView: BaseTableView {
    var currencyBalances = [CurrencyBalance]()
    var currentCurrency: String?
    
    override func onTableViewInitialized() {
        super.onTableViewInitialized()
        
        register(SelectionTableViewCell.self, forCellReuseIdentifier: "selectionTableViewCell")
        
        delegate = self
        dataSource = self
        
        tableHeaderView = UIView(frame: .zero)
        tableFooterView = UIView(frame: .zero)
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
    }
    
    func getDelegate() -> CurrencySelectionTableViewDelegate? {
        return baseTableViewDelegate as? CurrencySelectionTableViewDelegate
    }
}

extension CurrencySelectionTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectionTableViewCell") as! SelectionTableViewCell
        let currencyBalance = currencyBalances[indexPath.row]
        if currencyBalance.currency == currentCurrency {
            cell.transparentView.backgroundColor = .clear
        }
        cell.currencyBalance = currencyBalance
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Top Left Right Corners
        let maskPathTop = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        let shapeLayerTop = CAShapeLayer()
        shapeLayerTop.frame = cell.bounds
        shapeLayerTop.path = maskPathTop.cgPath
        
        //Bottom Left Right Corners
        let maskPathBottom = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        let shapeLayerBottom = CAShapeLayer()
        shapeLayerBottom.frame = cell.bounds
        shapeLayerBottom.path = maskPathBottom.cgPath
        
        //All Corners
        let maskPathAll = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomRight, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
        let shapeLayerAll = CAShapeLayer()
        shapeLayerAll.frame = cell.bounds
        shapeLayerAll.path = maskPathAll.cgPath
        
        if indexPath.row == 0, indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.layer.mask = shapeLayerAll
        } else if indexPath.row == 0 {
            cell.layer.mask = shapeLayerTop
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.layer.mask = shapeLayerBottom
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyBalances.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getDelegate()?.onCurrencySelected(balance: currencyBalances[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
