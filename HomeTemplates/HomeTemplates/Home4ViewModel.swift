//
//  Home4ViewModel.swift
//  HomeTemplates
//
//  Created by Kamil Tustanowski on 12.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation

class Home4ViewModel: BaseHomeViewModel {
    
    var cellViewModels: [Home4ItemCellViewModel] = []
    
    override func setup() {
        guard let items = items else {
            cellViewModels.removeAll()
            return
        }
        
        for item in items {
            if let cellViewModel = Home4ItemCellViewModel(item: item) {
                cellViewModels.append(cellViewModel)
            }
        }
    }
    
}

struct Home4ItemCellViewModel {
    
    let title: String
    
    init?(item: HomeItem) {
        title = item.title
    }
    
}
