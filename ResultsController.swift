//
//  ResultsController.swift
//  Outline
//
//  Created by Apple on 04/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//
import UIKit
import IGListKit
import GoogleMaps
import Parse

protocol goToDetailDelegate
{
    func goToDetail(vc: IGFriendsVC)
}

class ResultsController: UIViewController, UISearchResultsUpdating, ListAdapterDataSource, UserCellClicked1Delegator
{
    var arrayOfObjects = [User]()
    var arrayOfImageObjects = [User]()
    var arrayOfGatheringObjects = [Gathering]()
    var pretenObjectId: String = String()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    let data = [10]
    
    let refresher = UIRefreshControl()
    
    var button: UIButton!
    var detailViewController: IGFriendsVC? = nil
    
    var collectionView: UICollectionView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    var counter: Int = 1
    
    var xdelegate: goToDetailDelegate!
    
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0.99)
        collectionView.alwaysBounceVertical = true
        collectionView.isPrefetchingEnabled = false
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
//        let width = self.view.frame.size.width/2
//        button = UIButton(frame: CGRect(x: width, y: width, width: 50, height: 50))
//        button.setTitle("Press", for: .normal)
//        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//        self.view.addSubview(button)
        
        let multipleAttributes: [String : Any] = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1),
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue", size:13)!]
        let attributedString = NSMutableAttributedString(string: "More Posts Incoming ...", attributes: nil)
        
        refresher.tintColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1)
        refresher.attributedTitle = attributedString
        refresher.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        collectionView!.addSubview(refresher)
        
        searchEnteredText()
        
    }
    
    @objc func loadData()
    {
        //code to execute during refresher
        print("yolo")
        //sleep(4)
        self.searchEnteredText()
        //stopRefresher()         //Call this to stop refresher
    }
    
    func GoToSearchedIGFriendsVC1(_ user: User)
    {
        self.detailViewController = IGFriendsVC()
        self.detailViewController?.user = user
        self.xdelegate.goToDetail(vc: detailViewController!)
    }
    
    func stopRefresher()
    {
        refresher.endRefreshing()
    }
    
    @objc func buttonPressed()
    {
        print("pressed")
//        self.detailViewController = DestinationVC()
//
//        self.xdelegate.goToDetail()
        //self.navigationController?.present(self.detailViewController!, animated: true, completion: nil)
    }
    
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable]
    {
        var totalObjects = [ListDiffable]()
        //        let profileUser: [ListDiffable] = [User.current()!]
        let feedItems: [ListDiffable] = self.arrayOfObjects
        totalObjects = feedItems
        
        print("\(totalObjects.count)")
        return totalObjects as [ListDiffable]
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController
    {
        
        let xobject = object as! User
//        if xobject.numberIfPhoto == 1
//        {
            let somevc = SearchedUserSC()
            somevc.delegate = self
            //somevc.minimumInteritemSpacing = 5
            somevc.inset = UIEdgeInsetsMake(2.5, 0, 2.5, 0)
            return somevc
//        }
//        else if xobject.numberIfStatus == 1
//        {
//            let somevc = StatusPostSectionController()
//            //somevc.minimumInteritemSpacing = 5
//            somevc.inset = UIEdgeInsetsMake(2.5, 0, 2.5, 0)
//            return somevc
//        }
//        else if xobject.numberIfCheckIn == 1
//        {
//            let somevc = CheckInIGSectionVC()
//            //somevc.minimumInteritemSpacing = 5
//            somevc.inset = UIEdgeInsetsMake(2.5, 0, 2.5, 0)
//            return somevc
//        }
        //return ListSectionController()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.searchText = searchController.searchBar.text!
        
        //Do Stuff with the string
        
        DispatchQueue.main.async {
            //print(searchText)
            //self.tableView.reloadData()
            self.searchEnteredText()
            
        }
    }
    
    func searchEnteredText()
    {
        for index in 1...2 {
            if index == 1
            {
                let query = PFQuery(className: "_User")
                query.fromLocalDatastore()
                query.whereKey("username", contains: self.searchText)
                query.order(byDescending: "createdAt")
                //query.includeKey("UserWhoPosted")
                //query.includeKey("gathering")
                query.findObjectsInBackground { (objects, error) in
                    if objects != nil
                    {
                        let count = objects?.count
                        self.arrayOfObjects = objects! as! [User]
                        print("successfully found \(count!) objects from local datastore")
                        self.stopRefresher()
                        self.adapter.reloadData(completion: nil)
                        //self.stopRefresher()
                    }}
                
            }
            else if index == 2
            {
                let query = PFQuery(className: "_User")
                query.order(byDescending: "createdAt")
                query.whereKey("username", contains: self.searchText)
                //query.includeKey("UserWhoPosted")
                //query.includeKey("gathering")
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
                                        self.arrayOfObjects = objects! as! [User]
                                        print("successfully pinned \(count!) objects")
                                        self.stopRefresher()
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
    
    @available(iOS 2.0, *)
    public func emptyView(for listAdapter: ListAdapter) -> UIView?
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }
}
