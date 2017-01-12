//
//  HomeTemplate.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 11.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation

public protocol HomeActions: class {
    
    var longSelected: ((_ identifier: HomeItem)->())? { get set }
    var shortSelected: ((_ identifier: HomeItem)->())? { get set }
    var streamSelected: ((_ identifier: HomeItem)->())? { get set }
    var settingsSelected: (()->())? { get set }

}
