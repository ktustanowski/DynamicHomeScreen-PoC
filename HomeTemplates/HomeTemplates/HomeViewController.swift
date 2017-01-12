//
//  HomeViewController.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 10.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeActions, HasViewModel {

    var baseViewModel: BaseHomeViewModel? = BaseHomeViewModel()
    
    var longSelected: ((_ identifier: HomeItem)->())?
    var shortSelected: ((_ identifier: HomeItem)->())?
    var streamSelected: ((_ identifier: HomeItem)->())?
    var settingsSelected: (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parent?.title = "Home 1"
    }

    @IBAction func settingsButtonTapped() {
        settingsSelected?()
    }
    
    @IBAction func shortButtonTapped() {
        guard let item = baseViewModel?.items?.first else { return }
        
        shortSelected?(item)
    }
    
    @IBAction func longButtonTapped() {
        guard let item = baseViewModel?.items?.last else { return }
        
        longSelected?(item)
    }
    
}

