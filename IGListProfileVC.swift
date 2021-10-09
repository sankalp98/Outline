//
//  IGListProfileVC.swift
//  Outline
//
//  Created by Apple on 07/06/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit
import GoogleMaps
import Parse

class IGListProfileVC: UIViewController, NewMyCustomCellDelegator, ListAdapterDataSource {
    
    var user: User = User.current()!
    var delegate:NewMyCustomCellDelegator!
    //var IGGoToEditInfoDelegate:IGGoToEditInfo!
    
    var arrayOfObjects = [Post]()
    var arrayOfImageObjects = [Post]()
    
    var LocalDatastoreResults = [Post]()
    var NewServerResults = [Post]()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    var SettingsButton = UIBarButtonItem()
    
    let refresher = UIRefreshControl()
    
    var collectionView: UICollectionView!
    
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
        
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        label.textAlignment = .center
        //label.font = UIFont.boldSystemFontOfSize(20.0)
        label.font = UIFont(name: "SnellRoundhand-Bold", size: 23)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "Outlook"
        //self.navigationController.navigationBar.topItem.titleView = label
        self.navigationController?.navigationBar.topItem?.titleView = label
        
        self.navigationController?.hidesBarsOnSwipe = false
        
        let multipleAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.foregroundColor: UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1),
            NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size:13)!]
        let attributedString = NSMutableAttributedString(string: "More Posts Incoming ...", attributes: multipleAttributes)
        
        self.SettingsButton = UIBarButtonItem(title: "Settings", style: UIBarButtonItemStyle.plain , target: self, action: #selector(self.SettingsButtonPressed))
        SettingsButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = SettingsButton
        
        refresher.tintColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1)
        refresher.attributedTitle = attributedString
        refresher.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        collectionView!.addSubview(refresher)
        
        queryObjects()
    }
    
    @objc func loadData()
    {
        //code to execute during refresher
        print("yolo")
        //sleep(4)
        self.queryObjects()
        //stopRefresher()         //Call this to stop refresher
    }
    
    func stopRefresher()
    {
        refresher.endRefreshing()
    }
    
    @objc func SettingsButtonPressed()
    {
        print("Settings Button Pressed")
        let SettingsVC: Settings = Settings()
        //self.navigationController.
        self.navigationController?.pushViewController(SettingsVC, animated: true)
        //self.navigationController?.present(SettingsVC, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.backgroundColor = UIColor.white
        collectionView.frame = view.bounds
    }
    
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable]
    {
        var totalObjects = [ListDiffable]()
        let profileUser: [ListDiffable] = [User.current()!]
        let feedItems: [ListDiffable] = self.arrayOfObjects
        totalObjects = profileUser + feedItems
        
        print("\(totalObjects.count)")
        return totalObjects as [ListDiffable]
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController
    {
        
        if object is User
        {
            let somevc = HeaderSectionController()
            //somevc.minimumInteritemSpacing = 5
            somevc.inset = UIEdgeInsetsMake(0, 0, 0, 0)
            return somevc
        }
        else
        {
            let xobject = object as! Post
            if xobject.numberIfPhoto == 1
            {
                let somevc = PostSectionController()
                //somevc.minimumInteritemSpacing = 5
                somevc.inset = UIEdgeInsetsMake(2.5, 0, 2.5, 0)
                return somevc
            }
            else if xobject.numberIfStatus == 1
            {
                let somevc = StatusPostSectionController()
                //somevc.minimumInteritemSpacing = 5
                somevc.inset = UIEdgeInsetsMake(2.5, 0, 2.5, 0)
                return somevc
            }
            else if xobject.numberIfCheckIn == 1
            {
                let somevc = CheckInIGSectionVC()
                //somevc.minimumInteritemSpacing = 5
                somevc.inset = UIEdgeInsetsMake(2.5, 0, 2.5, 0)
                return somevc
            }
            
        }
        return ListSectionController()
    }
    
    func queryObjects()
    {
        for index in 1...2 {
            if index == 1
            {
                let query = PFQuery(className: "Posts")
                query.fromLocalDatastore()
                query.order(byDescending: "createdAt")
                query.whereKey("userID", equalTo: (User.current()?.objectId)!)
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
                    }}
                
            }
            else if index == 2
            {
                let query = PFQuery(className: "Posts")
                query.order(byDescending: "createdAt")
                query.whereKey("userID", equalTo: (User.current()?.objectId)!)
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
                                    }
                                }
                                )}
                            
                        })
                    }
                }
            }
        }
    }
    
    func callSegueFromCell(_ post: Post)
    {
        //self.performSegueWithIdentifier("Show Comments", sender: post)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        //let friendsController = FriendsController(collectionViewLayout: layout)
//        let xNewCommentsVC: NewCommentsVC = NewCommentsVC(collectionViewLayout: layout)
//        xNewCommentsVC.post = post
//
//        self.navigationController?.pushViewController(xNewCommentsVC, animated: true)
        
    }
    
    @available(iOS 2.0, *)
    public func emptyView(for listAdapter: ListAdapter) -> UIView?
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }
    
}
