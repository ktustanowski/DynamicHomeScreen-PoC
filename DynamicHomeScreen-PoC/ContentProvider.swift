//
//  ContentProvider.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 12.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation

struct ContentProvider {
    
    static func loadContent(completion: @escaping ([Content]?)->()) {
        let zeroItemOne = ContentItem(identifier: "0.1", title: "Zero Item One", description: "Zero Item One Description")
        let zeroItemTwo = ContentItem(identifier: "0.2", title: "Zero Item Two", description: "Zero Item Two Description")
        let zero = Content(identifier: "0", title: "Zero", description: "Zero Content Description", related: [zeroItemOne, zeroItemTwo], few: nil, less: nil, important: nil, parameters: nil, not: nil, neededIn: nil, home: nil)

        let firstItemOne = ContentItem(identifier: "1.1", title: "First Item One", description: "First Item One Description")
        let firstItemTwo = ContentItem(identifier: "1.2", title: "First Item Two", description: "First Item Two Description")
        let first = Content(identifier: "1", title: "First", description: "First Content Description", related: [firstItemOne, firstItemTwo], few: nil, less: nil, important: nil, parameters: nil, not: nil, neededIn: nil, home: nil)
        
        let second = Content(identifier: "2", title: "Second", description: "Second Content Description", related: nil, few: nil, less: nil, important: nil, parameters: nil, not: nil, neededIn: nil, home: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion([zero, first, second])
        }
    }
    
}
