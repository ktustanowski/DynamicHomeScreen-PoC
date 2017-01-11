//
//  HomeViewControllerFactory.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 11.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit

struct HomeFactory {
    
    static func create(withStyle style: Int) -> UIViewController? {
        let name = "Home\(style > 0 ? String(style + 1) : "")ViewController"
        guard
            let homeViewController = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()
            else { return nil }
        
        return homeViewController
    }
    
}
