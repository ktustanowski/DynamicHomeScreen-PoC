//
//  HomeViewControllerFactory.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 11.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit
import FeatureToggleSupport

public class HomeFactory {
    
    public static func create(withStyle style: Int) -> UIViewController? {
        let name = "Home\(style > 0 ? String(style + 1) : "")ViewController"
        guard
            let homeViewController = UIStoryboard(name: name, bundle: Bundle(for:self)).instantiateInitialViewController()
            else { return nil }
        
        return homeViewController
    }
    
}
