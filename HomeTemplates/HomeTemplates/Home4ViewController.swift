//
//  Home4ViewController.swift
//  HomeTemplates
//
//  Created by Kamil Tustanowski on 12.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import Foundation

class Home4ViewController: UITableViewController, HasViewModel, HomeActions, Refreshable, HomeReporting {
    
    var didHorizontalSwipe: (()->())?
    var didLaunch: (()->())?

    var baseViewModel: BaseHomeViewModel? = Home4ViewModel()

    var longSelected: ((_ identifier: HomeItem)->())?
    var shortSelected: ((_ identifier: HomeItem)->())?
    var streamSelected: ((_ identifier: HomeItem)->())?
    var replaceWith: ((UIViewController) -> ())?
    var settingsSelected: (()->())?
    
    var viewModel: Home4ViewModel? {
        return baseViewModel as? Home4ViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parent?.title = "Home 4"
        didLaunch?()
    }

    @IBAction func changeUiButtonTapped() {
        guard let newViewController = HomeFactory.create(withStyle: 0) else { return }
        /* we can do here any required setup i.e. inform what item should be displayed */
        replaceWith?(newViewController)
    }
}

extension Home4ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = viewModel?.cellViewModels[indexPath.row].title /* No cell vm implementation in sample app yet */
        
        return cell
    }
    
}

extension Home4ViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedItem = viewModel?.items?[indexPath.row] else { return }
        
        longSelected?(selectedItem)
    }
    
}

extension Home4ViewController {
    
    func refresh() {
        tableView.reloadData()
    }
    
}
