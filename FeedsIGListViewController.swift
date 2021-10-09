//
//  FeedsIGListViewController.swift
//  Outline
//
//  Created by Apple on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit
import GoogleMaps
import Parse

class FeedsIGListViewController: UIViewController, ListAdapterDataSource {
    
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
        label.textColor = UIColor.black
        label.text = "Outline"
        //self.navigationController.navigationBar.topItem.titleView = label
        self.navigationController?.navigationBar.topItem?.titleView = label
        
        self.CheckInButton = UIBarButtonItem(title: "CheckIn", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.CheckInPressed))
        CheckInButton.tintColor = UIColor.white
        self.ActivityButton = UIBarButtonItem(title: "Activity", style: UIBarButtonItemStyle.plain , target: self, action: #selector(self.ActivityButtonPressed))
        ActivityButton.tintColor = UIColor.black
        //self.navigationItem.leftBarButtonItem = CheckInButton
        self.navigationItem.rightBarButtonItem = ActivityButton
        
        self.navigationController?.hidesBarsOnSwipe = false
        
        let multipleAttributes: [String : Any] = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1),
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue", size:13)!]
        let attributedString = NSMutableAttributedString(string: "More Posts Incoming ...", attributes: nil)
        
        refresher.tintColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1)
        refresher.attributedTitle = attributedString
        refresher.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        collectionView!.addSubview(refresher)
        
        PFCloud.callFunction(inBackground: "hello", withParameters: nil) { (response, error) in
            let xresponse = response as? String
            print(xresponse)
        }
        
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
    
    @objc func ActivityButtonPressed()
    {
        let xActivityViewController = IGListActivityVC()
        self.navigationController?.pushViewController(xActivityViewController, animated: true)
    }
    
    @objc func CheckInPressed()
    {
        let gg = GMSAutocompleteViewController()
        gg.delegate = self
        let navVC = UINavigationController(rootViewController: gg)
        
        //let autocompleteController = GMSAutocompleteViewController()
        //autocompleteController.delegate = self
        self.present(navVC, animated: true) {
            //
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.backgroundColor = UIColor.white
        collectionView.frame = view.bounds
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
                query.includeKey("UserWhoPosted")
                query.includeKey("gathering")
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
                query.includeKey("UserWhoPosted")
                query.includeKey("gathering")
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
    
    
    @available(iOS 2.0, *)
    public func emptyView(for listAdapter: ListAdapter) -> UIView?
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }
    
}

@available(iOS 9.0, *)
extension FeedsIGListViewController: GMSAutocompleteViewControllerDelegate {
    /**
     * Called when a non-retryable error occurred when retrieving autocomplete predictions or place
     * details. A non-retryable error is defined as one that is unlikely to be fixed by immediately
     * retrying the operation.
     * <p>
     * Only the following values of |GMSPlacesErrorCode| are retryable:
     * <ul>
     * <li>kGMSPlacesNetworkError
     * <li>kGMSPlacesServerError
     * <li>kGMSPlacesInternalError
     * </ul>
     * All other error codes are non-retryable.
     * @param viewController The |GMSAutocompleteViewController| that generated the event.
     * @param error The |NSError| that was returned.
     */
    
    func viewController(_ viewController: GMSAutocompleteViewController, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        return true
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        //
        print("Error: ", error.localizedDescription)
    }
    
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress as Any)
        print("Place attributions: ", place.attributions as Any)
        print(place.coordinate.latitude)
        print(place.coordinate.longitude)
        
        let placename = place.name
        
        let xcurrentLoc = PFGeoPoint(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        let status = "is at - \(place.name)"
        let xPost = Post(shares: status, userID: PFUser.current()!.objectId!, xImageFile: nil, numberOfLikes: 0, xlocation: xcurrentLoc, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: false, locationName: placename, numberIfLocation: 0, numberIfStatus: 0, numberIfPhoto: 0, numberIfCheckIn: 1, isMapShown: 1, gathering: nil)
        
        xPost.saveInBackground { (success, error) -> Void in
            
            self.activityIndicator.stopAnimating()
            //self.locationManager.stopUpdatingLocation()
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
            
            if error == nil
            {
                //self.ImageToPost?.image = UIImage(named: "wow.png")
                //self.Opinion.text = ""
                self.displayAlert("CheckIn Posted", message: "Your checkin has been posted successfully")
            }
            else
            {
                print(error?.localizedDescription as Any)
                self.displayAlert("Could not post checkin", message: "Please try again later")
            }
        }
        
        self.queryObjects()
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayAlert(_ title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
            //self.navigationController?.dismiss(animated: true, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        }))
        
        //self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /*func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: NSError) {
     // TODO: handle the error.
     //print("Error: ", error.description)
     }*/
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
