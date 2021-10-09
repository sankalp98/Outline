//
//  SearchResultsController.swift
//  BaeToBye
//
//  Created by Apple on 24/09/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

protocol GoToUserDelegate {
    func GoToUser(_ xxUser: User)
}

protocol xdGoToUserDelegate {
    func xdGoToUserDelegate(_ xdUser: User)
}

@available(iOS 9.0, *)
class SearchResultsController: PFQueryTableViewController, UISearchResultsUpdating, xxxMyCustomCellDelegator {
    var searchString: String? {
        didSet{
            print("Text Added")
            self.loadObjects()
        }
    }
    
    var xdGoToUser: xdGoToUserDelegate!
    var xGoToUserDelegate:GoToUserDelegate!
    
    var pretenObjectId: String = String()
    
    override init(style: UITableViewStyle, className: String!)
    {
        super.init(style: style, className: className)
        
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        
        self.parseClassName = "_User"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        print("succeeded")
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerClass(PFSearchCell.self, forCellReuseIdentifier: "SearchCell")
        
        self.tabBarController?.tabBar.isHidden = false
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.allowsSelection = true
        
        //self.splitViewController?.delegate = self
        
        //self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
        
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //let XXViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("XXViewController") as! SearchResultsController
        
        print("Fuck youuuu")
        
        
        self.tableView.reloadData()
    }
    
    override func queryForTable() -> PFQuery<PFObject> {
        let query = User.query()
        //query!.whereKey("username", containsString: self.searchString)
        if self.searchString != nil
        {
            //query?.whereKey("username", equalTo: self.searchString!)
            query?.whereKey("username", contains: self.searchString!)
        }
        //query?.whereKey("username", equalTo: self.searchString!)
        return query!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let xobject = objectAtIndexPath(indexPath)
//        let ladka = xobject as! User
//        //self.xGoToUserDelegate.GoToUser(ladka)
//        self.performSegueWithIdentifier("xGoToUser", sender: xobject as! User)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let xobject = object(at: indexPath)
        let ladka = xobject as! User
        self.xdGoToUser.xdGoToUserDelegate(ladka)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "xGoToUser"
        {
            let ladka = sender as! User
            //self.xGoToUserDelegate.GoToUser(ladka)
            let controller = (segue.destination as! UINavigationController).topViewController as! IGFriendsVC
            controller.user = ladka
            //controller.UserID = ladka.objectId
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            
            
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, object: PFObject?) -> PFTableViewCell? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! PFSearchCell
        
        cell.xxdelegate = self
        
        cell.user = object as! User
        
        return cell
        
    }
    
//    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool
//    {
//        return true
//    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.loadObjects()
    }
    
    func xxxcallSegueFromCell(_ xxUser: User)
    {
        self.pretenObjectId = xxUser.objectId!
        //self.performSegueWithIdentifier("GoToUser", sender: xxUser)
        self.xGoToUserDelegate.GoToUser(xxUser)
        //self.presentViewController(FriendUserViewController(), animated: true) { () -> Void in
            //..
        //}
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
