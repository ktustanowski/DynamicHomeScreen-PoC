//
//  HomeViewController.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 10.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parent?.title = "Home 1"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

