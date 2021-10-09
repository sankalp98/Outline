//
//  CheckInVC.swift
//  Outline
//
//  Created by Apple on 16/07/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Photos
import Parse
import ParseUI
import IGListKit
import CoreLocation
import GoogleMaps

class CheckInPostVC: UIViewController, CLLocationManagerDelegate, whichGatheringSelectedDelegator, checkifPostPressedDelegator
{
    var CancelBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    var PostBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    
    var CaptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        label.text = "Select a place"
        label.isUserInteractionEnabled = true
        label.textColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        return label
    }()
    
    var activityIndicator = UIActivityIndicatorView()
    
    let containerView = UIView()
    
    let ShowRemoveMapContainerView = UIView()
    
    var ShowRemoveMapButton = UIButton()
    
    var isMapShown = false
    
    var placename = ""
    
    var MapContainerView = UIView()
    
    var location : PFGeoPoint!
    
    var xplace : GMSPlace!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var arrayOfGatheringObjects = [Gathering]()
    
    var xview: somexview!
    
    var somefadedBlackView = UIView()
    
    var someScrollView: UIScrollView!
    
    var PFlocation: PFGeoPoint!
    
    var theSelectedGathering: Gathering?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        CancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelButtonPressed))
        self.navigationItem.leftBarButtonItem = CancelBarButtonItem
        
        PostBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(PostButtonPressed))
        self.navigationItem.rightBarButtonItem = PostBarButtonItem
        
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        
        containerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44)
        
        CaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(CaptionLabel)
        
        containerView.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: CaptionLabel)
        containerView.addConstraintsWithFormat("V:|-5-[v0]-5-|", views: CaptionLabel)
        
        let tapG = UITapGestureRecognizer(target: self, action: #selector(self.placeNameTapped))
        tapG.numberOfTapsRequired = 1
        CaptionLabel.addGestureRecognizer(tapG)
        
        ShowRemoveMapContainerView.backgroundColor = .clear
        view.addSubview(ShowRemoveMapContainerView)
        
        ShowRemoveMapContainerView.anchor(top: containerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        self.ShowRemoveMapContainerView.addSubview(ShowRemoveMapButton)
        ShowRemoveMapButton.translatesAutoresizingMaskIntoConstraints = false
        ShowRemoveMapButton.backgroundColor = UIColor.clear
        ShowRemoveMapButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13)
        ShowRemoveMapButton.setTitle("Show Map", for: UIControlState())
        ShowRemoveMapButton.setTitleColor(UIColor.rgb(red: 93, green: 188, blue: 210), for: UIControlState())
        ShowRemoveMapButton.addTarget(self, action: #selector(self.ShowRemoveMapButtonPressed), for: UIControlEvents.touchUpInside)
        ShowRemoveMapButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        
        ShowRemoveMapContainerView.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: ShowRemoveMapButton)
        ShowRemoveMapContainerView.addConstraintsWithFormat("V:|-0-[v0]-0-|", views: ShowRemoveMapButton)
        ShowRemoveMapButton.alpha = 0
        
        MapContainerView.backgroundColor = .white
        view.addSubview(MapContainerView)
        MapContainerView.anchor(top: ShowRemoveMapContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        MapContainerView.alpha = 0
        
        self.locationManager.delegate = self
        
        self.queryGatheringObjects()
        
        let gg = GMSAutocompleteViewController()
        gg.delegate = self
        let navVC = UINavigationController(rootViewController: gg)
        
        self.present(navVC, animated: true) {
            
        }
        
    }
    
    func whichGatheringIsSelected(_ gathering: Gathering?) {
        let gg = gathering?.nameGathering
        self.theSelectedGathering = gathering
        self.CaptionLabel.text = "Select a place"
        self.CaptionLabel.textColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        ShowRemoveMapButton.alpha = 0
        self.isMapShown = true
        self.ShowRemoveMapButtonPressed()
        print(gg)
    }
    
    func checkIfPostIsPressed(_ trueOrFalse: Bool) {
        //self.PostButtonPressed()
        self.PostButtonPressed()
    }
    
    func addthexview()
    {
        self.xview = somexview(frame: CGRect(x: 0, y: self.navigationController!.view.frame.size.height-152, width: self.view.frame.size.width, height: 152))
        //print(self.arrayOfGatheringObjects)
        xview.arrayOfGatheringObjects = self.arrayOfGatheringObjects
        xview.isItInCheckIn = true
        xview.delegate = self
        xview.postButtonDelegate = self
        //xview.backgroundColor = UIColor.blue
        self.navigationController?.view.addSubview(xview)
        
        
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
                        self.addthexview()
                        //self.stopRefresher()
                        //self.adapter.reloadData(completion: nil)
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
                                        self.addthexview()
                                        //self.stopRefresher()
                                        //self.adapter.reloadData(completion: nil)
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
    
    @objc func placeNameTapped()
    {
        print("name tapped")
        let gg = GMSAutocompleteViewController()
        gg.delegate = self
        let navVC = UINavigationController(rootViewController: gg)
        
        self.present(navVC, animated: true) {
            
        }
        //self.AddMap()
    }
    
    
    
    @objc func ShowRemoveMapButtonPressed()
    {
        if self.isMapShown == false
        {
            self.isMapShown = true
            print("Map is shown")
            self.AddMap()
            ShowRemoveMapButton.setTitle("Remove Map", for: UIControlState())
            UIView.animate(withDuration: 0.5, animations: {
              self.MapContainerView.alpha = 1
            })
        }
        else
        {
            self.isMapShown = false
            print("Map is hidden")
            ShowRemoveMapButton.setTitle("Show Map", for: UIControlState())
            UIView.animate(withDuration: 0.5, animations: {
                self.MapContainerView.alpha = 0
            })
        }
        
    }
    
    func AddMap()
    {
        let camera = GMSCameraPosition.camera(withLatitude: self.location.latitude, longitude: self.location.longitude, zoom: 13)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.MapContainerView.addSubview(mapView)
        
        MapContainerView.addConstraintsWithFormat("H:|-0-[v0]-0-|", views: mapView)
        MapContainerView.addConstraintsWithFormat("V:|-0-[v0]-0-|", views: mapView)
        
        let currentLoc = CLLocationCoordinate2D(latitude: self.location.latitude, longitude: self.location.longitude)
        let marker = GMSMarker(position: currentLoc)
        marker.title = self.xplace.name
        marker.map = mapView
        
    }
    
    
    
    @objc func PostButtonPressed()
    {
        print("Post pressed")
        
        if (self.CaptionLabel.text != "Select a place" && isMapShown == true)
        {
            let xPost = Post(shares: self.CaptionLabel.text!, userID: PFUser.current()!.objectId!, xImageFile: nil, numberOfLikes: 0, xlocation: self.location, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: false, locationName: self.placename, numberIfLocation: 0, numberIfStatus: 0, numberIfPhoto: 0, numberIfCheckIn: 1, isMapShown: 1, gathering: self.theSelectedGathering)
            
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
        }
        else if (self.CaptionLabel.text != "Select a place" && isMapShown == false)
        {
            let xPost = Post(shares: self.CaptionLabel.text!, userID: PFUser.current()!.objectId!, xImageFile: nil, numberOfLikes: 0, xlocation: self.location, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: false, locationName: self.placename, numberIfLocation: 0, numberIfStatus: 0, numberIfPhoto: 0, numberIfCheckIn: 1, isMapShown: 0, gathering: self.theSelectedGathering)
            
            xPost.saveInBackground { (success, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                //self.locationManager.stopUpdatingLocation()
                
                UIApplication.shared.endIgnoringInteractionEvents()
                
                
                if error == nil
                {
                    //self.ImageToPost?.image = UIImage(named: "wow.png")
                    //self.Opinion.text = ""
                    self.displayAlert("Checkin Posted", message: "Your checkin has been posted successfully")
                }
                else
                {
                    print(error?.localizedDescription as Any)
                    self.displayAlert("Could not post checkin", message: "Please try again later")
                }
            }
        }
        else
        {
            print("Something wrong, probably place not selected yet")
        }
        
        if (self.CaptionLabel.text == "Select a place" && isMapShown == true && self.theSelectedGathering != nil)
        {
            var status = ""
            if let xyz = self.theSelectedGathering!.nameGathering
            {
                status = "is at - \(String(describing: xyz))"
            }
            let xPost = Post(shares: status, userID: PFUser.current()!.objectId!, xImageFile: nil, numberOfLikes: 0, xlocation: self.theSelectedGathering?.location, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: false, locationName: self.theSelectedGathering!.nameGathering, numberIfLocation: 0, numberIfStatus: 0, numberIfPhoto: 0, numberIfCheckIn: 1, isMapShown: 1, gathering: self.theSelectedGathering)
            
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
        }
        else if (self.CaptionLabel.text == "Select a place" && isMapShown == false && self.theSelectedGathering != nil)
        {
            var status = ""
            if let xyz = self.theSelectedGathering!.nameGathering
            {
                status = "is at - \(String(describing: xyz))"
            }
            //let status = "is at - \(String(describing: xyz))"
            let xPost = Post(shares: status, userID: PFUser.current()!.objectId!, xImageFile: nil, numberOfLikes: 0, xlocation: self.theSelectedGathering?.location, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: false, locationName: self.theSelectedGathering!.nameGathering, numberIfLocation: 0, numberIfStatus: 0, numberIfPhoto: 0, numberIfCheckIn: 1, isMapShown: 0, gathering: self.theSelectedGathering)
            
            xPost.saveInBackground { (success, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                //self.locationManager.stopUpdatingLocation()
                
                UIApplication.shared.endIgnoringInteractionEvents()
                
                
                if error == nil
                {
                    //self.ImageToPost?.image = UIImage(named: "wow.png")
                    //self.Opinion.text = ""
                    self.displayAlert("Checkin Posted", message: "Your checkin has been posted successfully")
                }
                else
                {
                    print(error?.localizedDescription as Any)
                    self.displayAlert("Could not post checkin", message: "Please try again later")
                }
            }
        }
        else
        {
            print("Something wrong, probably place not selected yet")
        }
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
    
    @objc func CancelButtonPressed()
    {
        print("Cancel pressed")
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}

@available(iOS 9.0, *)
extension CheckInPostVC: GMSAutocompleteViewControllerDelegate {
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
        //            let vc = CheckInPostVC()
        //            self.navigationController?.pushViewController(vc, animated: true)
        
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
        
        self.placename = place.name
        
        
        self.xplace = place
        let xcurrentLoc = PFGeoPoint(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        let status = "is at - \(place.name)"
        
        //            let xPost = Post(shares: status, userID: PFUser.current()!.objectId!, xImageFile: nil, numberOfLikes: 0, xlocation: xcurrentLoc, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: true, locationName: placename, numberIfLocation: 1, numberIfStatus: 0, numberIfPhoto: 0, numberIfCheckIn: 1)
        //            xPost.saveInBackground { (success, error) -> Void in
        //                if error == nil
        //                {
        //                    print("location post saved successfully")
        //                }
        //                else
        //                {
        //                    print(error?.localizedDescription as Any)
        //                }
        //            }
        
//        let vc = CheckInPostVC()
//        vc.CaptionLabel.text = status
        //navigationController?.pushViewController(vc, animated: true)
        
        self.location = xcurrentLoc
        
        self.CaptionLabel.textColor = UIColor.black
        self.CaptionLabel.text = status
        ShowRemoveMapButton.alpha = 1
        
        self.AddMap()
        
        self.xview.deselectAllExceptNone()
        
        //self.queryObjects()
        self.dismiss(animated: true, completion: nil)
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
