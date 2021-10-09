//
//  SharePhotoController.swift
//  Outline
//
//  Created by Apple on 29/06/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import CoreLocation

class SharePhotoController: UIViewController, UITextViewDelegate, whichGatheringSelectedDelegator, checkifPostPressedDelegator {
    
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }
    
    //var locationManager: CLLocationManager = CLLocationManager()
    
    var isLocationOn = false
    
     var activityIndicator = UIActivityIndicatorView()
    
    var location: PFGeoPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        textView.delegate = self
        textView.textColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        textView.text = "Write Something"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(PostButtonPressed))
        
        setupImageAndTextViews()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    var arrayOfGatheringObjects = [Gathering]()
    
    var xview: somexview!
    
    var somefadedBlackView = UIView()
    
    var theSelectedGathering: Gathering?
    
     var isGatheringsViewShown = false
    
    fileprivate func setupImageAndTextViews() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
        
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        self.somefadedBlackView = UIView()
        //self.somefadedBlackView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.somefadedBlackView.frame = (self.navigationController?.view.frame)!
        self.somefadedBlackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let tpxx = UITapGestureRecognizer(target: self, action: #selector(blackViewClicked))
        tpxx.numberOfTapsRequired = 1
        self.somefadedBlackView.addGestureRecognizer(tpxx)
        
        //self.locationManager.delegate = self
        
        self.queryGatheringObjects()

    }
    
    @objc func blackViewClicked()
    {
        self.showHideGatheringsView()
    }
    
    func whichGatheringIsSelected(_ gathering: Gathering?) {
        let gg = gathering?.nameGathering
        self.theSelectedGathering = gathering
        print(gg)
    }
    
    func checkIfPostIsPressed(_ trueOrFalse: Bool) {
        self.PostButtonPressed()
        self.SecondPartOfPostButtonPressed()
    }
    
    func addthexview()
    {
        
        self.xview = somexview(frame: CGRect(x: 0, y: self.navigationController!.view.frame.size.height, width: self.view.frame.size.width, height: 152))
        //print(self.arrayOfGatheringObjects)
        xview.arrayOfGatheringObjects = self.arrayOfGatheringObjects
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
    
    @objc func PostButtonPressed()
    {
        self.showHideGatheringsView()
    }
    
    func showHideGatheringsView()
    {
        if self.isGatheringsViewShown == false
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationController?.view.addSubview(self.somefadedBlackView)
                self.addthexview()
                self.isGatheringsViewShown = true
                //self.view.addSubview(self.somefadedBlackView)
                
                //                var currentWindow = UIApplication.shared.keyWindow
                //                currentWindow?.addSubview(self.somefadedBlackView)
                
                let ok = self.xview.frame.size.height
                self.xview.frame.origin.y = self.navigationController!.view.frame.size.height-ok
                //self.ggsomeview.frame.origin.y = self.view.frame.size.height-ok
            }) { (success) in
                //self.hideGatherignsView()
            }
        }
        else
        {
            self.isGatheringsViewShown = false
            UIView.animate(withDuration: 0.2, animations: {
                self.somefadedBlackView.removeFromSuperview()
                
                self.xview.frame.origin.y = self.navigationController!.view.frame.size.height
            }) { (success) in
                //
            }
        }
    }
    
    func SecondPartOfPostButtonPressed() {
        print("Sharing photo")
        
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        if isLocationOn == true
        {
            print("Location is on")
            let imageData = UIImagePNGRepresentation(self.selectedImage!)
            
            let imageFile = PFFile(name: "image.png", data: imageData!)
            
            let z = imageFile
            
            print(location)
            
            let xPost = Post(shares: self.textView.text, userID: PFUser.current()!.objectId!, xImageFile: z, numberOfLikes: 0, xlocation: self.location, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: false, locationName: "", numberIfLocation: 0, numberIfStatus: 0, numberIfPhoto: 1, numberIfCheckIn: 0, isMapShown: 0, gathering: theSelectedGathering)
            
            xPost.saveInBackground { (success, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                //self.locationManager.stopUpdatingLocation()
                
                UIApplication.shared.endIgnoringInteractionEvents()
                
                
                if error == nil
                {
                    //self.ImageToPost?.image = UIImage(named: "wow.png")
                    //self.Opinion.text = ""
                    self.displayAlert("Image Posted", message: "Your image has been posted successfully")
                }
                else
                {
                    print(error?.localizedDescription as Any)
                    self.displayAlert("Could not post image", message: "Please try again later")
                }
            }
        }
        else
        {
            print("Location not on")
            
            let imageData = UIImagePNGRepresentation(self.selectedImage!)
            
            let imageFile = PFFile(name: "image.png", data: imageData!)
            
            let z = imageFile
            
            let xPost = Post(shares: self.textView.text, userID: PFUser.current()!.objectId!, xImageFile: z, numberOfLikes: 0, xlocation: nil, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: false, locationName: "", numberIfLocation: 0, numberIfStatus: 0, numberIfPhoto: 1, numberIfCheckIn: 0, isMapShown: 0, gathering: theSelectedGathering)
            
            xPost.saveInBackground { (success, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                //self.locationManager.stopUpdatingLocation()
                
                UIApplication.shared.endIgnoringInteractionEvents()
                
                
                if error == nil
                {
                    //self.ImageToPost?.image = UIImage(named: "wow.png")
                    //self.Opinion.text = ""
                    self.displayAlert("Image Posted", message: "Your image has been posted successfully")
                }
                else
                {
                    print(error?.localizedDescription as Any)
                    self.displayAlert("Could not post image", message: "Please try again later")
                }
            }
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
        if textView.textColor == UIColor.rgb(red: 240, green: 240, blue: 240)
        {
            textView.text = ""
        }
        textView.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        if textView.text.isEmpty
        {
            textView.text = "Write Something"
            textView.textColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
