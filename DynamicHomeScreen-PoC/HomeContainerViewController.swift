//
//  HomeContainerViewController.swift
//  DynamicHomeScreen-PoC
//
//  Created by Kamil Tustanowski on 11.01.2017.
//  Copyright © 2017 ktustanowski. All rights reserved.
//

import UIKit
import HomeTemplates

enum SegueIdentifier: String {
    case homeToSettings = "HomeToSettings"
    case homeToLong = "HomeToLong"
    case homeToShort = "HomeToShort"
    case homeToStream = "HomeToStream"
}

class HomeContainerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedHomeViewController()
        loadData()
    }
    
    func embedHomeViewController() {
        guard
            let viewController = HomeFactory.create(withStyle: SettingsProvider.homeStyle)
            else { return }
        
        addChildViewController(viewController)
        viewController.view.frame = view.frame
        view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
        
        if let homeViewController = viewController as? HomeActions {
            homeViewController.settingsSelected = { [weak self] in
                self?.performSegue(withIdentifier: SegueIdentifier.homeToSettings.rawValue, sender: self)
            }

            homeViewController.longSelected = { [weak self] item in
                self?.performSegue(withIdentifier: SegueIdentifier.homeToLong.rawValue, sender: item)
            }

            homeViewController.shortSelected = { [weak self] item in
                self?.performSegue(withIdentifier: SegueIdentifier.homeToShort.rawValue, sender: item)
            }

            homeViewController.streamSelected = { [weak self] item in
                self?.performSegue(withIdentifier: SegueIdentifier.homeToStream.rawValue, sender: item)
            }
        }
    }
 
    func loadData() {
        ContentProvider.loadContent { [weak self] contents in
            guard
                let contents = contents,
                let viewControllerWithViewModel = self?.childViewControllers.first as? HasViewModel,
                let refreshableViewController = self?.childViewControllers.first as? Refreshable
                else { return }
            
                viewControllerWithViewModel.baseViewModel?.items = contents.map({ $0 as HomeItem })
                refreshableViewController.refresh()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier != SegueIdentifier.homeToSettings.rawValue else { return }
        
        if let destination = segue.destination as? HasContent,
            let content = sender as? Content {
            destination.content = content
        }
    }
    
    @IBAction func refreshButtonTapped() {
        loadData()
    }
    
}

