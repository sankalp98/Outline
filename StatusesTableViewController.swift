//
//  StatusesTableViewController.swift
//  BaeToBye
//
//  Created by Apple on 17/09/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI

protocol xTableViewContentSizeHeight {
    func xcallForHeightOfTableView(height: CGFloat)
}

class StatusesTableViewController: PFQueryTableViewController, MyCustomCellDelegator {
    
    let indexxPath:NSIndexPath = NSIndexPath()
    let cell2:UITableViewCell = UITableViewCell()
    var hellooo: NSIndexPath = NSIndexPath(index: 0)
    var heightdelegator:xTableViewContentSizeHeight!
    
    override init(style: UITableViewStyle, className: String!)
    {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        
        self.parseClassName = "Posts"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        //self.objectsPerPage = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = false
        tableView.estimatedRowHeight = 387.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.allowsSelection = true
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 15)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.hidesBarsOnSwipe = false
        self.tabBarController?.tabBar.hidden = false
        
        self.tableView.scrollEnabled = false
        
        print("succeeded")
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        print(" ye hai \(self.tableView.contentSize.height)")
        //self.preferredContentSize.height = self.tableView.contentSize.height
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(" ye hai \(self.tableView.contentSize.height)")
        if self.heightdelegator != nil
        {
            //self.heightdelegator.xcallForHeightOfTableView(self.tableView.contentSize.height)
            //self.preferredContentSize.height = self.tableView.contentSize.height
        }
        else
        {
            print("fucked")
            self.preferredContentSize.height = self.tableView.contentSize.height
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Posts")
        query.orderByDescending("createdAt")
        query.whereKeyDoesNotExist("ImageFiles")
        query.cachePolicy = .CacheThenNetwork
        return query
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Comments"
        {
            let destinVC = segue.destinationViewController as! CommentsViewController
            destinVC.hidesBottomBarWhenPushed = true
            destinVC.post = sender as! Post
        }
    }
    
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.cell2 == tableView.cellForRowAtIndexPath(indexPath)
    self.performSegueWithIdentifier("Show Comments", sender: self)
    }*/
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let reportAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Report") { (action, indexPath) -> Void in
            let  reportMenu = UIAlertController(title: "Report", message: "Reason", preferredStyle: UIAlertControllerStyle.ActionSheet)
            let abuseReport = UIAlertAction(title: "Abusive", style: UIAlertActionStyle.Default, handler: nil)
            
            let inappropriateReport = UIAlertAction(title: "Inappropriate", style: UIAlertActionStyle.Default, handler: nil)
            
            let cancelReport = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            reportMenu.addAction(abuseReport)
            reportMenu.addAction(inappropriateReport)
            reportMenu.addAction(cancelReport)
            
            self.presentViewController(reportMenu, animated: true, completion: nil)
            
        }
        return [reportAction]
    }
    
    
    
    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    let x = objects?.count
    return x!
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30
    }*/
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        //var cell1 = tableView.dequeueReusableCellWithIdentifier("cell1") as! ImagePostCell
        let cell2 = tableView.dequeueReusableCellWithIdentifier("cell2") as! ImagePostCell
        
        let xobject = object as! Post
        
        //let gg = objectAtIndexPath(indexPath+hellooo) as! Post
        
            cell2.post = xobject
            cell2.delegate = self
            return cell2
    }
    
    
    func callSegueFromCell(post: Post)
    {
        self.performSegueWithIdentifier("Show Comments", sender: post)
    }
}
