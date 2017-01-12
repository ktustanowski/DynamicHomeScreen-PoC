//
//  HomeViewController.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 10.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeActions {

    var longSelected: ((_ identifier: String)->())?
    var shortSelected: ((_ identifier: String)->())?
    var streamSelected: ((_ identifier: String)->())?
    var settingsSelected: (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parent?.title = "Home 1"
    }

    @IBAction func settingsButtonTapped() {
        settingsSelected?()
    }
    
    @IBAction func shortButtonTapped() {
        shortSelected?("1")
    }
    
    @IBAction func longButtonTapped() {
        longSelected?("1")
    }
    
}

