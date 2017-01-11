//
//  HomeTemplate.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 11.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation

protocol HomeActions: class {
    
    var longSelected: ((_ id: String)->())? { get set }
    var shortSelected: ((_ id: String)->())? { get set }
    var streamSelected: ((_ id: String)->())? { get set }
    var settingsSelected: (()->())? { get set }

}
