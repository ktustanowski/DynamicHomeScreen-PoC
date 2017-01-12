//
//  Home2ViewController.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 11.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit

class Home2ViewController: UIViewController, HomeActions, HasViewModel {
    
    var baseViewModel: BaseHomeViewModel? = BaseHomeViewModel()
    
    var longSelected: ((_ identifier: HomeItem)->())?
    var shortSelected: ((_ identifier: HomeItem)->())?
    var streamSelected: ((_ identifier: HomeItem)->())?
    var settingsSelected: (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parent?.title = "Home 2"
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
    
    @IBAction func streamButtonTapped() {
        guard let item = baseViewModel?.items?[1] else { return }
        
        streamSelected?(item)
    }

}
