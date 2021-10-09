//
//  IGListActivityVC.swift
//  Outline
//
//  Created by Apple on 31/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

class IGListActivityVC: UIViewController, ListAdapterDataSource
{
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    var user: User = User.current()!
    
    var arrayOfObjects = [Activity]()
    
    var LocalDatastoreResults = [Activity]()
    var NewServerResults = [Activity]()
    
    let cellId = "activityCell"
    
    let refresher = UIRefreshControl()
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        label.text = "Recent Updates"
        //self.navigationController.navigationBar.topItem.titleView = label
        navigationItem.titleView = label
        
        self.navigationController?.hidesBarsOnSwipe = false
        
        //let multipleAttributes: [String : Any] = [NSAttributedStringKey.foregroundColor.rawValue: UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1),NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue", size:13)!]
        let attributedString = NSAttributedString(string: "More Posts Incoming ...", attributes: [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: "HelveticaNeue", size:13)!])
        //let xstring = NSMutableAttributedString(string: "More posts incoming ...", attributes: multipleAttributes)
        
        refresher.tintColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1)
        refresher.attributedTitle = attributedString
        refresher.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        collectionView!.addSubview(refresher)
        
        queryObjects()
        
    }
    
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable]
    {
        let feedItems: [ListDiffable] = self.arrayOfObjects
        print("\(feedItems.count)")
        return feedItems as [ListDiffable]
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController
    {
        let somevc = ActivityLikeAndCommentSectionController()
        somevc.inset = UIEdgeInsetsMake(2.5, 0, 2.5, 0)
        return somevc
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //collectionView.backgroundColor = UIColor.gray
        collectionView.frame = view.bounds
    }
    
    @available(iOS 2.0, *)
    public func emptyView(for listAdapter: ListAdapter) -> UIView?
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
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
    
    func queryObjects()
    {
        for index in 1...2 {
            if index == 1
            {
                let query = PFQuery(className: "Activity")
                query.fromLocalDatastore()
                query.order(byDescending: "createdAt")
                query.includeKey("UserWhoInitiatedActivity")
                query.includeKey("OnPost")
                query.includeKey("UserOnWhomActivtyIsDone")
                query.findObjectsInBackground { (objects, error) in
                    if objects != nil
                    {
                        let count = objects?.count
                        self.arrayOfObjects = objects! as! [Activity]
                        print("successfully found \(count!) objects from local datastore")
                        self.stopRefresher()
                        self.adapter.reloadData(completion: nil)
                        //self.stopRefresher()
                    }}
                
            }
            else if index == 2
            {
                let query = PFQuery(className: "Activity")
                query.order(byDescending: "createdAt")
                query.includeKey("UserWhoInitiatedActivity")
                query.includeKey("OnPost")
                query.includeKey("UserOnWhomActivtyIsDone")
                query.findObjectsInBackground { (objects, error) in
                    if objects != nil
                    {
                        let count = objects?.count
                        PFObject.unpinAllObjectsInBackground(withName: "ActivityLogs", block: { (success, error) in
                            if success == true
                            {
                                PFObject.pinAll(inBackground: objects, withName: "ActivityLogs", block: { (success, error) in
                                    if success == true
                                    {
                                        self.arrayOfObjects = objects! as! [Activity]
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
}
