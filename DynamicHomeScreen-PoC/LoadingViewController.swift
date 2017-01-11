//
//  LoadingViewController.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 10.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var homeStyleSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeStyleSegmentedControl.addTarget(self, action: #selector(homeStyleChanged), for: .valueChanged)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.performSegue(withIdentifier: "LoadingToEmbededHome", sender: nil)
        }
    }
    
    func homeStyleChanged() {
        SettingsProvider.homeStyle = homeStyleSegmentedControl.selectedSegmentIndex
    }
}
