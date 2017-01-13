//
//  UIViewController+Embedding.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 13.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func embed(_ viewController: UIViewController) {
        addChildViewController(viewController)
        viewController.view.frame = view.frame
        view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
    
    func removeEmbedded(_ viewController: UIViewController) {
        
    }
}
