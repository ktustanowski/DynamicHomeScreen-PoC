//
//  HomeReporting.swift
//  HomeTemplates
//
//  Created by Kamil Tustanowski on 13.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation

public protocol HomeReporting: class {
    
    var didHorizontalSwipe: (()->())? { get set }
    var didLaunch: (()->())? { get set }
    
}
