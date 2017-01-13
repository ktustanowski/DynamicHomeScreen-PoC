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
        
        setupActions(for: viewController)
        setupReporting(for: viewController)
        
        embed(viewController)
    }
    
    @IBAction func refreshButtonTapped() {
        loadData()
    }
}

//MARK: Actions
extension HomeContainerViewController {
    
    func setupActions(for viewController: UIViewController) {
        guard let actionViewController = viewController as? HomeActions else { return }
        
        actionViewController.settingsSelected = { [weak self] in
            self?.performSegue(withIdentifier: SegueIdentifier.homeToSettings.rawValue, sender: self)
        }
        
        actionViewController.longSelected = { [weak self] item in
            self?.performSegue(withIdentifier: SegueIdentifier.homeToLong.rawValue, sender: item)
        }
        
        actionViewController.shortSelected = { [weak self] item in
            self?.performSegue(withIdentifier: SegueIdentifier.homeToShort.rawValue, sender: item)
        }
        
        actionViewController.streamSelected = { [weak self] item in
            self?.performSegue(withIdentifier: SegueIdentifier.homeToStream.rawValue, sender: item)
        }
        
        actionViewController.replaceWith = { [weak self] newViewController in
            guard let viewController = self?.childViewControllers.first else { return }

            self?.replace(viewController: viewController, with: newViewController)
            self?.loadData()
        }
    }
    
    func replace(viewController: UIViewController, with newViewController: UIViewController) {
        self.setupActions(for: newViewController)
        self.setupReporting(for: newViewController)

        viewController.willMove(toParentViewController: nil)
        addChildViewController(newViewController)
        newViewController.view.alpha = 0
        
        transition(from: viewController,
                   to: newViewController,
                   duration: 1.0,
                   options: UIViewAnimationOptions.curveLinear,
                   animations: {
                    newViewController.view.alpha = 1.0
                    viewController.view.alpha = 0.0
        },
                   completion: { [weak self] finished in
                    viewController.removeFromParentViewController()
                    newViewController.didMove(toParentViewController: self)
        })
    }
    
}

//MARK: Reporting
extension HomeContainerViewController {
    
    func setupReporting(for viewController: UIViewController) {
        guard let reportingViewController = viewController as? HomeReporting else { return }
        
        reportingViewController.didLaunch = {
            print("Report: Did Launch")
        }
        
        reportingViewController.didHorizontalSwipe = {
            print("Report: Did Horizontal Swipe")
        }
    }
    
}

//MARK: Navigation
extension HomeContainerViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier != SegueIdentifier.homeToSettings.rawValue else { return }
        
        if let destination = segue.destination as? HasContent,
            let content = sender as? Content {
            destination.content = content
        }
    }
}

//MARK: Data loading
extension HomeContainerViewController {
    
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
}
