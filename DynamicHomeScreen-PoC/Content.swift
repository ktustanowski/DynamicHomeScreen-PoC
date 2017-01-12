//
//  ContentModel.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 12.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit
import HomeTemplates

struct Content: HomeItem {
    
    let identifier: String
    let title: String
    let description: String?
    let related: [ContentItem]?
    
    let few: String?
    let less: String?
    let important: String?
    let parameters: String?
    let not: String?
    let neededIn: String?
    let home: String?
}

struct ContentItem {
    
    let identifier: String
    let title: String
    let description: String?
    
}
