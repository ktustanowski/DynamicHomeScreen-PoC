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
        
        embedHomeViewController()
    }
    
    func embedHomeViewController() {
        guard
            let viewController = HomeFactory.create(withStyle: SettingsProvider.homeStyle)
            else { return }
        
        addChildViewController(viewController)
        viewController.view.frame = view.frame
        view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
        
        if let homeViewController = viewController as? HomeActions {
            homeViewController.settingsSelected = { [weak self] in
                self?.performSegue(withIdentifier: "HomeToSettings", sender: self)
            }

            homeViewController.longSelected = { [weak self] _ in
                self?.performSegue(withIdentifier: "HomeToLong", sender: self)
            }

            homeViewController.shortSelected = { [weak self] _ in
                self?.performSegue(withIdentifier: "HomeToShort", sender: self)
            }

            homeViewController.streamSelected = { [weak self] _ in
                self?.performSegue(withIdentifier: "HomeToStream", sender: self)
            }
        }
    }
    
}
