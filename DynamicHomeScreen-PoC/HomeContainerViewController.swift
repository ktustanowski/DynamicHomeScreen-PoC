//
//  HomeContainerViewController.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 11.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit

class HomeContainerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHomeViewController()
    }
    
    func addHomeViewController() {
        guard
            let homeViewController = HomeFactory.create(withStyle: SettingsProvider.homeStyle)
            else { return }
        
        addChildViewController(homeViewController)
        homeViewController.view.frame = view.frame
        view.addSubview(homeViewController.view)
        homeViewController.didMove(toParentViewController: self)
    }
    
}
