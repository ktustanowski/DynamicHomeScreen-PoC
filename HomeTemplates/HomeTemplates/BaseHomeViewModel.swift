//
//  BaseHomeViewModel.swift
//  HomeTemplates
//
//  Created by Kamil Tustanowski on 12.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation

public class BaseHomeViewModel {
    
    public var items: [HomeItem]? {
        didSet {
            setup()
        }
    }

    func setup() {
        /* override in subclasses */
    }
}
