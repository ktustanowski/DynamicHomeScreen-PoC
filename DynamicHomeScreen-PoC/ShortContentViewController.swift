//
//  ShortContentViewController.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 10.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit

class ShortContentViewController: UIViewController, HasContent {
 
    var content: Content?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = content?.title
    }
    
}
