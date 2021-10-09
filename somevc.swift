//
//  File.swift
//  Outline
//
//  Created by Apple on 04/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchControllerDelegate, goToDetailDelegate, UISplitViewControllerDelegate {
    func goToDetail(vc: IGFriendsVC) {
        //
    }
    
    
    var detailViewController: DestinationVC = DestinationVC()
    var navBar = UINavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Loaded")
        view.backgroundColor = UIColor.white
        
        let searchResultsController = ResultsController()
        searchResultsController.xdelegate = self
        let searchController = UISearchController(searchResultsController: searchResultsController)
        
        searchController.delegate = self
        //searchController.searchBar.showsCancelButton = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        navigationController?.navigationBar.topItem?.titleView = searchController.searchBar
        
        navigationController?.navigationBar.prefersLargeTitles = false
        //navigationItem.title = "Outline"
        
        self.splitViewController?.delegate = self
        
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible
        
        //        if let splitViewController = splitViewController {
        //            let controllers = splitViewController.viewControllers
        //            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DestinationVC
        //        }
        
    }
    
    func goToDetail()
    {
        let ok = self.detailViewController
        let nv = UINavigationController(rootViewController: ok)
        ok.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        ok.navigationItem.leftItemsSupplementBackButton = true
        self.showDetailViewController(nv, sender: self)
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool
    {
        return true
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchResultsController?.view.isHidden = false
        }
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchResultsController?.view.isHidden = false
        }
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
