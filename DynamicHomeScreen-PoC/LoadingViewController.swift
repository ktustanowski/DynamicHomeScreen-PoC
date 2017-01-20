//
//  LoadingViewController.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 10.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit
import FeatureToggleSupport

class LoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.performSegue(withIdentifier: "LoadingToEmbededHome", sender: nil)
        }
    }

    @IBAction func awesomeFaetureStateChanged(_ sender: UISwitch) {
        ToggleRouter.awesomeFeature = sender.isOn
    }
    
    @IBAction func homeStyleChanged(_ sender: UISegmentedControl) {
        SettingsProvider.homeStyle = sender.selectedSegmentIndex
    }
}
