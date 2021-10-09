//
//  IGCommentsVC.swift
//  Outline
//
//  Created by Apple on 26/01/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import IGListKit
import Parse
import ParseUI

class IGCommentsVC: UIViewController, ListAdapterDataSource {
    
    
    var post: Post!
    var userWhoPosted: User!
    var captionofPost: String!
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    var arrayOfObjects = [IGComment]()
    
    let refresher = UIRefreshControl()
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Comments"
        
        self.view.backgroundColor = UIColor.white
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0.99)
        collectionView.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .interactive
        collectionView.isPrefetchingEnabled = false
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        
        let multipleAttributes: [String : Any] = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1),
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue", size:13)!]
        let attributedString = NSMutableAttributedString(string: "More Posts Incoming ...", attributes: nil)
        
        refresher.tintColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1)
        refresher.attributedTitle = attributedString
        refresher.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        collectionView!.addSubview(refresher)
        
        self.queryObjects()
    }
    
    @objc func loadData()
    {
        //code to execute during refresher
        print("yolo")
        //sleep(4)
        self.queryObjects()
        //stopRefresher()         //Call this to stop refresher
    }
    
    func queryObjects()
    {
        for index in 1...2 {
            if index == 1
            {
                let query = PFQuery(className: "IGComment")
                query.fromLocalDatastore()
                query.whereKey("post", equalTo: self.post)
                 query.order(byAscending: "createdAt")
                query.includeKey("userWhoPosted")
                query.includeKey("post")
                query.findObjectsInBackground { (objects, error) in
                    if objects != nil
                    {
                        let count = objects?.count
                        self.arrayOfObjects = objects! as! [IGComment]
                        print("successfully found \(count!) objects from local datastore")
                        self.stopRefresher()
                        self.adapter.reloadData(completion: nil)
                        //self.stopRefresher()
                    }}
                
            }
            else if index == 2
            {
                let query = PFQuery(className: "IGComment")
                query.whereKey("post", equalTo: self.post)
                query.order(byAscending: "createdAt")
                query.includeKey("userWhoPosted")
                query.includeKey("post")
                query.findObjectsInBackground { (objects, error) in
                    if objects != nil
                    {
                        let count = objects?.count
                        PFObject.unpinAllObjectsInBackground(withName: "comments", block: { (success, error) in
                            if success == true
                            {
                                PFObject.pinAll(inBackground: objects, withName: "comments", block: { (success, error) in
                                    if success == true
                                    {
                                        self.arrayOfObjects = objects! as! [IGComment]
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
    
    func stopRefresher()
    {
        refresher.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.backgroundColor = UIColor.white
        collectionView.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        containerView.addSubview(submitButton)
        submitButton.anchor(top: containerView.topAnchor, left: nil, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 0)
        
        containerView.addSubview(self.commentTextField)
        self.commentTextField.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: submitButton.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let lineSeparatorView = UIView()
        lineSeparatorView.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        containerView.addSubview(lineSeparatorView)
        lineSeparatorView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        return containerView
    }()
    
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Comment"
        return textField
    }()
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable]
    {
        var totalObjects = [ListDiffable]()
        let comment = IGComment(post: self.post, userWhoPosted: self.userWhoPosted, comment: captionofPost)
        let firstItem: [ListDiffable] = [comment]
        let feedItems: [ListDiffable] = self.arrayOfObjects
        totalObjects = firstItem + feedItems
        
        print("\(totalObjects.count)")
        return totalObjects as [ListDiffable]
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController
    {
        let xobject = object as! IGComment
        let somevc = IGCommentSectionController()
        //somevc.minimumInteritemSpacing = 5
        somevc.inset = UIEdgeInsetsMake(2.5, 0, 2.5, 0)
        return somevc
    }
    
    @objc func handleSubmit() {
        print("Handling Submit...")
        let comment = IGComment(post: self.post, userWhoPosted: User.current()!, comment: self.commentTextField.text!)
        comment.saveInBackground { (success, error) in
            if error == nil
            {
                print("Comment saved")
            }
        }
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    @available(iOS 2.0, *)
    public func emptyView(for listAdapter: ListAdapter) -> UIView?
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
