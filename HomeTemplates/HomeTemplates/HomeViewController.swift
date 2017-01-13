//
//  HomeViewController.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 10.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeActions, HasViewModel, HomeReporting {
    
    var didHorizontalSwipe: (()->())?
    var didLaunch: (()->())?

    var baseViewModel: BaseHomeViewModel? = BaseHomeViewModel()

    var longSelected: ((_ identifier: HomeItem)->())?
    var shortSelected: ((_ identifier: HomeItem)->())?
    var streamSelected: ((_ identifier: HomeItem)->())?
    var replaceWith: ((UIViewController) -> ())?
    var settingsSelected: (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parent?.title = "Home 1"
        didLaunch?()
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
    
    @IBAction func changeUiButtonTapped() {
        guard let newViewController = HomeFactory.create(withStyle: 3) else { return }
        /* we can do here any required setup i.e. inform what item should be displayed */
        replaceWith?(newViewController)
    }
}

