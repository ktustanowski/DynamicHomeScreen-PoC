//
//  Home2ViewController.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 11.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit

class Home2ViewController: UIViewController, HomeActions {
    
    var longSelected: ((_ id: String)->())?
    var shortSelected: ((_ id: String)->())?
    var streamSelected: ((_ id: String)->())?
    var settingsSelected: (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parent?.title = "Home 2"
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
    
    @IBAction func streamButtonTapped() {
        streamSelected?("1")
    }

}
