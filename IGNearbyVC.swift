//
//  IGNearbyVC.swift
//  Outline
//
//  Created by Apple on 21/06/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit
import GoogleMaps
import Parse

class IGNearbyVC: UIViewController, ListAdapterDataSource, CLLocationManagerDelegate, xdGoToUserDelegate, goToDetailDelegate, UISearchControllerDelegate, UISplitViewControllerDelegate, UISearchBarDelegate {
    func goToDetail(vc: IGFriendsVC) {
        //
    }
    
    
    
    var user: User = User.current()!
    
    var arrayOfObjects = [Post]()
    var arrayOfImageObjects = [Post]()
    var arrayOfGatheringObjects = [Gathering]()
    
    var LocalDatastoreResults = [Post]()
    var NewServerResults = [Post]()
    
    var pretenObjectId: String = String()
    
    
    var CheckInButton: UIBarButtonItem = UIBarButtonItem()
    var ActivityButton : UIBarButtonItem = UIBarButtonItem()
    
    var shouldShowSearchResults = false
    
    var customSearchController: CustomSearchController!
    
    var resultsController: SearchResultsController = SearchResultsController()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    let data = [10]
    
    let refresher = UIRefreshControl()
    
    var xcurrentLocation: PFGeoPoint = PFGeoPoint()
    
    var collectionView: UICollectionView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    var detailViewController: DestinationVC = DestinationVC()
    
    var counter: Int = 1
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0.99)
        collectionView.alwaysBounceVertical = true
        collectionView.isPrefetchingEnabled = false
        view.addSubview(collectionView)
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.xcurrentLocation = PFGeoPoint(location: locationManager.location)
        
        print("succeeded")
        print(CLLocationManager.locationServicesEnabled())
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        setUpSearchThings()
        
//        self.navigationController?.navigationBar.topItem?.titleView = label
        
        self.navigationController?.hidesBarsOnSwipe = false
        
        let multipleAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.foregroundColor: UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1),
            NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size:13)!]
        let attributedString = NSMutableAttributedString(string: "More Posts Incoming ...", attributes: multipleAttributes)
        
        refresher.tintColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1)
        refresher.attributedTitle = attributedString
        refresher.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        collectionView!.addSubview(refresher)
        
        queryGatheringObjects()
        queryObjects()
    }
    
    func setUpSearchThings()
    {
        let searchResultsController = ResultsController()
        searchResultsController.xdelegate = self
        let searchController = UISearchController(searchResultsController: searchResultsController)
        
        searchController.delegate = self
        searchController.searchResultsUpdater = searchResultsController
        //searchController.searchBar.showsCancelButton = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        //searchController.searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
        //navigationItem.searchController = searchController
        //self.navigationItem.titleView = searchController.searchBar
        
//        let leftNavBarButton = UIBarButtonItem(customView: searchController.searchBar)
//        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        //navigationController?.navigationBar.prefersLargeTitles = false
        //navigationItem.title = "Outline"
        
        self.splitViewController?.delegate = self
        
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible
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
    
    @objc func loadData()
    {
        //code to execute during refresher
        print("yolo")
        //sleep(4)
        self.queryGatheringObjects()
        self.queryObjects()
        //stopRefresher()         //Call this to stop refresher
    }
    
//    func configureCustomSearchController() {
//        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let xv = SearchResultsController()
//        self.resultsController = xv
//        customSearchController = CustomSearchController(searchResultsController: self.resultsController, searchBarFrame: CGRect(x: 0.0,y: 0.0,width: self.view.frame.size.width, height: 50.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: UIColor.orange, searchBarTintColor: UIColor.black)
//        customSearchController.searchResultsUpdater = resultsController
//
//        self.resultsController.xdGoToUser = self
//        customSearchController.customSearchBar.placeholder = "Search"
//        self.navigationItem.titleView = customSearchController.customSearchBar
//        self.definesPresentationContext = true
//        //tblSearchResults.tableHeaderView = customSearchController.customSearchBar
//
//        customSearchController.customDelegate = self
//    }
    
    func stopRefresher()
    {
        refresher.endRefreshing()
    }
    
    func ActivityButtonPressed()
    {
        let xActivityViewController = IGListActivityVC()
        self.navigationController?.pushViewController(xActivityViewController, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.backgroundColor = UIColor.white
        collectionView.frame = view.bounds
    }
    
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable]
    {
        var totalObjects = [ListDiffable]()
        let number: [ListDiffable] = self.data as [ListDiffable]
        //let gatheringobjects: [ListDiffable] = self.arrayOfGatheringObjects
        let feedItems: [ListDiffable] = self.arrayOfObjects
        totalObjects = number + feedItems
        
        print("\(totalObjects.count)")
        return totalObjects as [ListDiffable]
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        // note that each child section controller is designed to handle an Int (or no data)
        if object is Post
        {
            let xobject = object as! Post
            if xobject.numberIfPhoto == 1
            {
                let sectionController = ListStackedSectionController(sectionControllers: [
                    PostSectionController()
                    ])
                sectionController.inset = UIEdgeInsets(top: 2.5, left: 0, bottom: 2.5, right: 0)
                return sectionController
            }
            else if xobject.numberIfStatus == 1
            {
                let sectionController = ListStackedSectionController(sectionControllers: [
                    StatusPostSectionController()
                    ])
                sectionController.inset = UIEdgeInsets(top: 2.5, left: 0, bottom: 2.5, right: 0)
                return sectionController
            }
        }
        else
        {
            let scuks = HorizontalSectionController()
            scuks.arrayOfGatherings = self.arrayOfGatheringObjects
            print(self.arrayOfGatheringObjects.count)
            let sectionController = ListStackedSectionController(sectionControllers: [
                scuks
                ])
            sectionController.inset = UIEdgeInsets(top: 2.5, left: 0, bottom: 2.5, right: 0)
            return sectionController
        }
        return ListSectionController()
    }
    
    
    func didStartSearching() {
        shouldShowSearchResults = true
        self.customSearchController.view.isHidden = false
        self.customSearchController.searchResultsController?.view.isHidden = false
        //searchController.searchResultsController.
    }
    
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            self.customSearchController.searchResultsController?.view.isHidden = false
            if self.customSearchController.searchBar.text != ""
            {
                //self.customSearchController.customSearchBar.text = self.searchController.searchBar.text
                self.resultsController.searchString = self.customSearchController.searchBar.text
            }
        }
    }
    
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        self.customSearchController.searchResultsController?.view.isHidden = true
        //tblSearchResults.reloadData()
    }
    
    
    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        
        // Reload the tableview.
        self.customSearchController.searchResultsController?.view.isHidden = false
        if self.customSearchController.searchBar.text != ""
        {
            //self.customSearchController.customSearchBar.text = self.searchController.searchBar.text
            self.resultsController.searchString = self.customSearchController.searchBar.text
        }
    }
    
    func xdGoToUserDelegate(_ xdUser: User)
    {
        self.pretenObjectId = xdUser.objectId!
        //self.performSegueWithIdentifier("ShowDetail", sender: xdUser)
        
        let detailViewController : IGFriendsVC = IGFriendsVC()
        let detailNavigationController = UINavigationController(rootViewController: detailViewController)
        let gg1 = detailNavigationController.topViewController as! IGFriendsVC
        gg1.user = xdUser
        //gg1.nola = xdUser
        //gg1.UserID = self.pretenObjectId
        gg1.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        gg1.navigationItem.leftItemsSupplementBackButton = true
        self.showDetailViewController(detailNavigationController, sender: self)
    }
    
    func queryGatheringObjects()
    {
        for index in 1...2 {
            if index == 1
            {
                let query = PFQuery(className: "Gathering")
                query.fromLocalDatastore()
                query.order(byDescending: "createdAt")
                query.includeKey("UserWhoPosted")
                query.findObjectsInBackground { (objects, error) in
                    if objects != nil
                    {
                        let count = objects?.count
                        self.arrayOfGatheringObjects = objects! as! [Gathering]
                        print("successfully found \(count!) gathering objects from local datastore")
                        //self.stopRefresher()
                        self.adapter.reloadData(completion: nil)
                        //self.stopRefresher()
                    }}
                
            }
            else if index == 2
            {
                let query = PFQuery(className: "Gathering")
                query.order(byDescending: "createdAt")
                query.includeKey("UserWhoPosted")
                query.findObjectsInBackground { (objects, error) in
                    if objects != nil
                    {
                        let count = objects?.count
                        PFObject.unpinAllObjectsInBackground(withName: "posts", block: { (success, error) in
                            if success == true
                            {
                                PFObject.pinAll(inBackground: objects, withName: "posts", block: { (success, error) in
                                    if success == true
                                    {
                                        self.arrayOfGatheringObjects = objects! as! [Gathering]
                                        print("successfully pinned \(count!) gathering objects")
                                        //self.stopRefresher()
                                        self.adapter.reloadData(completion: nil)
                                        //self.stopRefresher()
                                    }
                                }
                                )}
                            
                        })
                    }
                }
            }
        }
    }
    
    func queryObjects()
    {
        for index in 1...2 {
            if index == 1
            {
                PFGeoPoint.geoPointForCurrentLocation { (geoPoint, error) -> Void in
                    if error == nil
                    {
                        self.xcurrentLocation = geoPoint!
                        
                    }
                    else
                    {
                        self.locationManager.startUpdatingLocation()
                        self.xcurrentLocation = PFGeoPoint(location: self.locationManager.location)
                        self.locationManager.stopUpdatingLocation()
                    }
                }
                
                let todaysdate: Date = Date()
                let yesterDay: Date = todaysdate.addingTimeInterval(-60*60*24*1)
                
                let query = PFQuery(className: "Posts")
                query.fromLocalDatastore()
                query.order(byDescending: "createdAt")
                let withinKilometers = Double((Float(self.counter))*0.7)
                print("\(withinKilometers)")
                query.whereKey("location", nearGeoPoint: xcurrentLocation, withinKilometers: withinKilometers)
                query.whereKey("createdAt", lessThanOrEqualTo: todaysdate)
                query.whereKey("createdAt", greaterThanOrEqualTo: yesterDay)
                query.includeKey("UserWhoPosted")
                query.findObjectsInBackground { (objects, error) in
                    if objects != nil
                    {
                        let count = objects?.count
                        self.arrayOfObjects = objects! as! [Post]
                        print("successfully found \(count!) objects from local datastore")
                        self.stopRefresher()
                        self.adapter.reloadData(completion: nil)
                        //self.stopRefresher()
                        if (objects?.count)! >= 0 && (objects?.count)! <= 10 && self.counter <= 3
                        {
                            print("\(self.counter)")
                            self.counter += 1
                            self.queryObjects()
                        }
                    }}
                
            }
            else if index == 2
            {
                PFGeoPoint.geoPointForCurrentLocation { (geoPoint, error) -> Void in
                    if error == nil
                    {
                        self.xcurrentLocation = geoPoint!
                        
                    }
                    else
                    {
                        self.locationManager.startUpdatingLocation()
                        self.xcurrentLocation = PFGeoPoint(location: self.locationManager.location)
                        self.locationManager.stopUpdatingLocation()
                    }
                }
                
                let todaysdate: Date = Date()
                let yesterDay: Date = todaysdate.addingTimeInterval(-60*60*24*1)
                
                let query = PFQuery(className: "Posts")
                query.order(byDescending: "createdAt")
                let withinKilometers = Double((Float(self.counter))*0.7)
                print("\(withinKilometers)")
                query.whereKey("location", nearGeoPoint: xcurrentLocation, withinKilometers: withinKilometers)
                query.whereKey("createdAt", lessThanOrEqualTo: todaysdate)
                query.whereKey("createdAt", greaterThanOrEqualTo: yesterDay)
                query.includeKey("UserWhoPosted")
                query.findObjectsInBackground { (objects, error) in
                    if objects != nil
                    {
                        let count = objects?.count
                        PFObject.unpinAllObjectsInBackground(withName: "posts", block: { (success, error) in
                            if success == true
                            {
                                PFObject.pinAll(inBackground: objects, withName: "posts", block: { (success, error) in
                                    if success == true
                                    {
                                        self.arrayOfObjects = objects! as! [Post]
                                        print("successfully pinned \(count!) objects")
                                        self.stopRefresher()
                                        self.adapter.reloadData(completion: nil)
                                        //self.stopRefresher()
                                        if (objects?.count)! >= 0 && (objects?.count)! <= 10 && self.counter <= 3
                                        {
                                            print("\(self.counter)")
                                            self.counter += 1
                                            self.queryObjects()
                                        }
                                    }
                                }
                                )}
                            
                        })
                    }
                }
            }
        }
    }
    
    
    @available(iOS 2.0, *)
    public func emptyView(for listAdapter: ListAdapter) -> UIView?
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }
    
}
