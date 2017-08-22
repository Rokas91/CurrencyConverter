//
//  AccountSelectionTableView.swift
//  CurrencyConverter
//
//  Created by Rokas on 20/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit

protocol AccountSelectionTableViewDelegate: BaseTableViewDelegate {
    func onAccountSelected(wallet: Wallet, balance: CurrencyBalance)
}

class AccountSelectionTableView: BaseTableView {
    var currentWallet: Wallet?
    var currentCurrency: String?
    var sections = [AccountSection]()
    
    init() {
        super.init(frame: .zero, style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func onTableViewInitialized() {
        super.onTableViewInitialized()
        
        register(SelectionTableViewHeaderCell.self, forHeaderFooterViewReuseIdentifier: "selectionTableViewHeaderCell")
        register(SelectionTableViewCell.self, forCellReuseIdentifier: "selectionTableViewCell")
        
        delegate = self
        dataSource = self
        
        tableHeaderView = UIView(frame: .zero)
        tableFooterView = UIView(frame: .zero)
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
    }
    
    func getDelegate() -> AccountSelectionTableViewDelegate? {
        return baseTableViewDelegate as? AccountSelectionTableViewDelegate
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension AccountSelectionTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "selectionTableViewHeaderCell") as! SelectionTableViewHeaderCell
        sectionHeader.wallet = sections[section].wallet
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wallet = sections[indexPath.section].wallet
        let currencyBalances = sections[indexPath.section].currencyBalances
        let currencyBalance = currencyBalances[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectionTableViewCell") as! SelectionTableViewCell
        if let currentWallet = currentWallet, wallet.id == currentWallet.id, currencyBalance.currency == currentCurrency {
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
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].currencyBalances.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currencyBalance = sections[indexPath.section].currencyBalances[indexPath.row]
        getDelegate()?.onAccountSelected(wallet: sections[indexPath.section].wallet, balance: currencyBalance)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
