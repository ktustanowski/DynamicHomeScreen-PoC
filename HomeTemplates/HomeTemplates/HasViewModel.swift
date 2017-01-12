//
//  HasViewModel.swift
//  HomeTemplates
//
//  Created by Kamil Tustanowski on 12.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation

public protocol HasViewModel: class {
    
    var baseViewModel: BaseHomeViewModel? { get }
    
}
