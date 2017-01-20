//
//  FeatureTogglable.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 20.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation

public protocol FeatureTogglable: class {
    
    var decorate: (() -> ())? { get set }
    
}
