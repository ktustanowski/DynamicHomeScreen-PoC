//
//  FeatureDecisions.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 13.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation

struct FeatureDecisions {
    
    static var isAwesomeFeatureEnabled: Bool {
        return ToggleRouter.awesomeFeature
    }
    
}
