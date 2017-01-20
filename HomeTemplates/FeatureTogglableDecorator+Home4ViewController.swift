//
//  FeatureTogglableDecorator+Home4.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 13.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation
import FeatureToggleSupport

extension FeatureTogglableDecorator {
    
    static func decorate(object: Home4ViewController) {
        object.decorate = { [weak object] in
            if FeatureDecisions.isAwesomeFeatureEnabled {
                object?.parent?.title = "Awesome Home 4"
                object?.decorateCell = { cell in
                    cell.backgroundColor = UIColor.orange
                    cell.textLabel?.textColor = UIColor.white
                }
            }
        }
    }
    
}
