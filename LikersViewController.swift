//
//  LikersViewController.swift
//  Outline
//
//  Created by Apple on 24/12/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class LikersViewController: UITableViewController {
    
    var likerIds = [String]()
    var likers = [User]()
    var pretenObjectId = String()
    var post: Post!
    
    var sahihai: Int!
    
    var tempUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.queryForTable()

        
    }
    
    func queryForTable() {
        let query = PFQuery(className: "Posts")
        query.order(byDescending: "createdAt")
        query.whereKey("objectId", equalTo: self.post.objectId!)
        query.cachePolicy = PFCachePolicy.cacheThenNetwork
        query.findObjectsInBackground { (objects, error) -> Void in
            if objects?.count > 0
            {
                for object in objects!
                {
                    if error == nil
                    {
                        let pointerLikers = object["likers"] as! [User]
                        self.likers = pointerLikers
                        self.tableView.reloadData()
                        print(self.likers.count)
                        let xquery = PFQuery(className: "_User")
                        xquery.order(byDescending: "createdAt")
                        //for (var index = 0; index < objects?.count; index += 1)
                        let vghi = objects
                        for var hola in vghi! {
                            xquery.whereKey("objectId", equalTo: self.likers[0].objectId!)
                            xquery.cachePolicy = PFCachePolicy.cacheThenNetwork
                            xquery.findObjectsInBackground(block: { (object, error) -> Void in
                                //
                            })
                        }
                    }
                    else
                    {
                        print("Error is There")
                    }
                }
            }
            else
            {
                //print("objects are 0")
            }
        }
    }
    
    func queryForLikerPointer() {
        for someone in likers
        {
            someone.fetchInBackground(block: { (object, error) -> Void in
                
            })
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.likers.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1") as! LikersCell
        cell1.userWhoLiked = self.likers[(indexPath as NSIndexPath).row]
        return cell1
    }
    
    func callSegueFromCell(_ post: Post)
    {
        self.performSegue(withIdentifier: "Show Comments", sender: post)
    }
    
    
    func xxcallSegueFromCell(_ xxUser: User)
    {
        self.pretenObjectId = xxUser.objectId!
        self.performSegue(withIdentifier: "GoToUser", sender: xxUser)
    }
    
}
