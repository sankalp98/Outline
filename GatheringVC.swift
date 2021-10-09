//
//  GatheringVC.swift
//  Outline
//
//  Created by Apple on 04/10/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit
import GoogleMaps
import Parse

class GatheringVC: UIViewController, ListAdapterDataSource {
    
    var user: User = User.current()!
    //var delegate:NewMyCustomCellDelegator!
    
    var arrayOfObjects = [Post]()
    var arrayOfImageObjects = [Post]()
    var arrayOfGatheringObjects = [Gathering]()
    
    var activityIndicator = UIActivityIndicatorView()
    
    var LocalDatastoreResults = [Post]()
    var NewServerResults = [Post]()
    
    var CheckInButton: UIBarButtonItem = UIBarButtonItem()
    var ActivityButton : UIBarButtonItem = UIBarButtonItem()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    let refresher = UIRefreshControl()
    
    var infoButton : UIBarButtonItem = UIBarButtonItem()
    
    let data = [10]
    
    var collectionView: UICollectionView!
    
    var gathering: Gathering!
    
    var timerLabel: UILabel!
    
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
        label.text = "Gathering"
        //self.navigationController.navigationBar.topItem.titleView = label
        //self.navigationController?.navigationBar.topItem?.titleView = label
        
        self.infoButton = UIBarButtonItem(title: "Info", style: UIBarButtonItemStyle.plain , target: self, action: #selector(self.infoGatheringPressed))
        infoButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = infoButton
        
        self.navigationController?.hidesBarsOnSwipe = false
        
        let multipleAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.foregroundColor: UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1),
            NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size:13)!]
        let attributedString = NSMutableAttributedString(string: "More Posts Incoming ...", attributes: multipleAttributes)
        
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
        //        let profileUser: [ListDiffable] = [User.current()!]
        let feedItems: [ListDiffable] = self.arrayOfObjects
        totalObjects = number + feedItems
        
        print("\(totalObjects.count)")
        return totalObjects as [ListDiffable]
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController
    {
        
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
            else if xobject.numberIfCheckIn == 1
            {
                let sectionController = ListStackedSectionController(sectionControllers: [
                    CheckInIGSectionVC()
                    ])
                sectionController.inset = UIEdgeInsets(top: 2.5, left: 0, bottom: 2.5, right: 0)
                return sectionController
            }
        }
        else
        {
            let scuks = GatheringHeaderSectionController()
            scuks.gathering = self.gathering
            print(self.arrayOfGatheringObjects.count)
            let sectionController = ListStackedSectionController(sectionControllers: [
                scuks
                ])
            sectionController.inset = UIEdgeInsets(top: 2.5, left: 0, bottom: 2.5, right: 0)
            return sectionController
        }
        return ListSectionController()
    }
    
    @objc func infoGatheringPressed()
    {
        let actionSheet = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        
        let xview = UIView(frame: CGRect(x: 8.0, y: 8.0, width: actionSheet.view.bounds.size.width - 8.0 * 4.5, height: 120.0))
        xview.backgroundColor = UIColor.clear
        actionSheet.view.addSubview(xview)
        
        self.timerLabel = UILabel(frame: xview.frame)
        timerLabel.text = "11:11"
        timerLabel.textColor = UIColor.red
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        xview.addSubview(timerLabel)
        
        if self.gathering.UserWhoCreated == self.user
        {
            actionSheet.addAction(UIAlertAction(title: "Close event", style: .default, handler: nil))
            actionSheet.addAction(UIAlertAction(title: "Delete event", style: .default, handler: nil))
        }
        else
        {
            actionSheet.addAction(UIAlertAction(title: "Report event", style: .default, handler: nil))
            actionSheet.addAction(UIAlertAction(title: "Recieve updates from this event", style: .default, handler: nil))
        }
        //actionSheet.addAction(UIAlertAction(title: "Create Playlist", style: .default, handler: nil))
        //actionSheet.addAction(UIAlertAction(title: "Remove from this Playlist", style: .default, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    func queryObjects()
    {
        for index in 1...2 {
            if index == 1
            {
                let query = PFQuery(className: "Posts")
                query.fromLocalDatastore()
                query.order(byDescending: "createdAt")
                query.whereKey("gathering", equalTo: self.gathering)
                query.includeKey("gathering")
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
                query.whereKey("gathering", equalTo: self.gathering)
                query.includeKey("gathering")
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
    
    
    @available(iOS 2.0, *)
    public func emptyView(for listAdapter: ListAdapter) -> UIView?
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }
    
}
