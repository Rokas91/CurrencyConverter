//
//  MainViewController.swift
//  CurrencyConverter
//
//  Created by Rokas on 18/08/2017.
//  Copyright © 2017 Rokas. All rights reserved.
//

import UIKit
import Typhoon

class MainViewController: BaseViewController {
    var userManager: UserManager!
    var realmDataFixture: RealmDataFixture!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = userManager.user {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Konvertuoti", style: .plain, target: self, action: #selector(convertTapped))
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sugeneruoti pirminius duomenis", style: .plain, target: self, action: #selector(dataGenerationTapped))
        }
        
    }
}


// MARK: - Selectors

extension MainViewController {
    
    fileprivate dynamic func dataGenerationTapped() {
        realmDataFixture.loadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Konvertuoti", style: .plain, target: self, action: #selector(convertTapped))
    }
    
    fileprivate dynamic func convertTapped() {
    }
}
