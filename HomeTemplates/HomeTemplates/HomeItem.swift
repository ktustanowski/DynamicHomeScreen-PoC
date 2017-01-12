//
//  Content.swift
//  HomeTemplates
//
//  Created by Kamil Tustanowski on 12.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation

/**
 General item for all the Home View Controllers, gathering all stuff needed for all of them. 
 Parameters:
 Non-optional - stuff common to all, 
 optional - at least one does not need this
 */
public protocol HomeItem {
    
    var identifier: String { get }
    var title: String { get }
    var description: String? { get }
    
}
