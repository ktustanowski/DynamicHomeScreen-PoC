//
//  FeatureDecisions.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 13.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation

public struct FeatureDecisions {
    
    public static var isAwesomeFeatureEnabled: Bool {
        return ToggleRouter.awesomeFeature
    }
    
}
