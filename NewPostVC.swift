//
//  NewPostVC.swift
//  Outline
//
//  Created by Apple on 24/06/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import CoreLocation
import GoogleMaps

class NewPostVC: UIViewController
{
    
    var MenuButtonOpened = false
    
    var Menubutton: FLoatingButton = {
        let Menubutton = FLoatingButton()
        Menubutton.backgroundColor = UIColor(hex: "2259B2")
        Menubutton.frame.size = CGSize(width: 100, height: 100)
        Menubutton.layer.cornerRadius = (Menubutton.frame.size.width/2)
        Menubutton.addTarget(self, action: #selector(MenuButtonPressed), for: .touchUpInside)
        Menubutton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 15)
        Menubutton.setTitle("Menu", for: UIControlState.normal)
        return Menubutton
    }()
    
    var Statusbutton: FLoatingButton = {
        let Statusbutton = FLoatingButton()
        Statusbutton.backgroundColor = UIColor(hex: "2259B2")
        Statusbutton.frame.size = CGSize(width: 100, height: 100)
        Statusbutton.layer.cornerRadius = (Statusbutton.frame.size.width/2)
        Statusbutton.addTarget(self, action: #selector(StatusButtonPressed), for: .touchUpInside)
        Statusbutton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 15)
        Statusbutton.setTitle("Status", for: UIControlState.normal)
        return Statusbutton
    }()
    
    var Picturebutton: FLoatingButton = {
        let Picturebutton = FLoatingButton()
        Picturebutton.backgroundColor = UIColor(hex: "2259B2")
        Picturebutton.frame.size = CGSize(width: 100, height: 100)
        Picturebutton.layer.cornerRadius = (Picturebutton.frame.size.width/2)
        Picturebutton.addTarget(self, action: #selector(PictureButtonPressed), for: .touchUpInside)
        Picturebutton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 15)
        Picturebutton.setTitle("Photo", for: UIControlState.normal)
        return Picturebutton
    }()
    
    var CheckInbutton: FLoatingButton = {
        let CheckInbutton = FLoatingButton()
        CheckInbutton.backgroundColor = UIColor(hex: "2259B2")
        CheckInbutton.frame.size = CGSize(width: 100, height: 100)
        CheckInbutton.layer.cornerRadius = (CheckInbutton.frame.size.width/2)
        CheckInbutton.addTarget(self, action: #selector(CheckInButtonPressed), for: .touchUpInside)
        CheckInbutton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 15)
        CheckInbutton.setTitle("CheckIn", for: UIControlState.normal)
        return CheckInbutton
    }()
    
    var Gatheringbutton: FLoatingButton = {
        let Gatheringbutton = FLoatingButton()
        Gatheringbutton.backgroundColor = UIColor(hex: "2259B2")
        Gatheringbutton.frame.size = CGSize(width: 100, height: 100)
        Gatheringbutton.layer.cornerRadius = (Gatheringbutton.frame.size.width/2)
        Gatheringbutton.addTarget(self, action: #selector(GatheringButtonPressed), for: .touchUpInside)
        Gatheringbutton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 15)
        Gatheringbutton.setTitle("Gathering", for: UIControlState.normal)
        return Gatheringbutton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        self.view.addSubview(Statusbutton)
        self.view.addSubview(Picturebutton)
        self.view.addSubview(CheckInbutton)
        self.view.addSubview(Gatheringbutton)
        self.view.addSubview(Menubutton)
        
        Menubutton.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        Statusbutton.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        Picturebutton.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        CheckInbutton.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        Gatheringbutton.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        
//        let CustomxView = CustomView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: CustomxView)
        
//        CustomButtonbutton.layer.shadowOffset = CGSize(width: 50, height: 50)
//        CustomButtonbutton.layer.shadowRadius = 5
//        CustomButtonbutton.layer.shadowColor = UIColor.lightGray.cgColor
//        CustomButtonbutton.layer.shadowOpacity = 1.0
    }
    
    @objc func MenuButtonPressed()
    {
        if self.MenuButtonOpened == false
        {
            UIView.animate(withDuration: 0.3) {
                self.Menubutton.transform = CGAffineTransform(scaleX: 8, y: 8)
                self.Statusbutton.transform = CGAffineTransform(scaleX: 8, y: 8)
                self.Picturebutton.transform = CGAffineTransform(scaleX: 8, y: 8)
                self.CheckInbutton.transform = CGAffineTransform(scaleX: 8, y: 8)
                self.Gatheringbutton.transform = CGAffineTransform(scaleX: 8, y: 8)
            }
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
                self.Menubutton.backgroundColor = UIColor(hex: "01114D")
                self.Menubutton.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.Statusbutton.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.Picturebutton.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.CheckInbutton.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.Gatheringbutton.transform = CGAffineTransform(scaleX: 1, y: 1)
                
                self.Statusbutton.transform = CGAffineTransform(translationX: 0, y: -100)
                self.CheckInbutton.transform = CGAffineTransform(translationX: -100, y: 0)
                self.Picturebutton.transform = CGAffineTransform(translationX: 100, y: 0)
                self.Gatheringbutton.transform = CGAffineTransform(translationX: 0, y: 100)
            }, completion: nil)
            self.MenuButtonOpened = true
        }
        else
        {
            UIView.animate(withDuration: 0.3) {
                self.Menubutton.transform = CGAffineTransform(scaleX: 8, y: 8)
                self.Statusbutton.transform = CGAffineTransform(scaleX: 8, y: 8)
                self.Picturebutton.transform = CGAffineTransform(scaleX: 8, y: 8)
                self.CheckInbutton.transform = CGAffineTransform(scaleX: 8, y: 8)
                self.Gatheringbutton.transform = CGAffineTransform(scaleX: 8, y: 8)
            }
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
                self.Menubutton.backgroundColor = UIColor(hex: "2259B2")
                self.Menubutton.transform = .identity
                self.Statusbutton.transform = .identity
                self.Picturebutton.transform = .identity
                self.CheckInbutton.transform = .identity
                self.Gatheringbutton.transform = .identity
            }, completion: nil)
            self.MenuButtonOpened = false
        }
    }
    
    @objc func StatusButtonPressed()
    {
        let xviewcontroller = StatusPostVC()
        let navigationVC = UINavigationController(rootViewController: xviewcontroller)
        navigationVC.modalPresentationStyle = .overCurrentContext
//        let CustomxView = CustomView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let xxxcustomview = CustomStatusNavbarView(frame: CGRect(x: 0, y: 0, width: 110, height: 30))
        navigationVC.navigationBar.topItem?.titleView = xxxcustomview
        self.tabBarController?.present(navigationVC, animated: true, completion: nil)
        //self.present(navigationVC, animated: true, completion: nil)
        
        UIView.animate(withDuration: 0.3) {
            self.Menubutton.transform = CGAffineTransform(scaleX: 8, y: 8)
        }
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            self.Menubutton.transform = .identity
        }, completion: nil)
    }
    
    @objc func GatheringButtonPressed()
    {
        let vc = GatheringCreateVC()
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.modalPresentationStyle = .overCurrentContext
        //        let CustomxView = CustomView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let xxxcustomview = CustomGatheringNavbarView(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        navigationVC.navigationBar.topItem?.titleView = xxxcustomview
        self.tabBarController?.present(navigationVC, animated: true, completion: nil)
        
    }
    @objc func PictureButtonPressed()
    {
//        let xviewcontroller = PhotoPostVC()
//        let navigationVC = UINavigationController(rootViewController: xviewcontroller)
//        navigationVC.modalPresentationStyle = .overCurrentContext
//        self.present(navigationVC, animated: true, completion: nil)
        
        let layout = UICollectionViewFlowLayout()
        let vc = PhotoSelectorController(collectionViewLayout: layout)
        vc.isAphotopost = true
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.modalPresentationStyle = .overCurrentContext
        let xxxcustomview = CustomPhotoNavbarView(frame: CGRect(x: 0, y: 0, width: 110, height: 30))
        navigationVC.navigationBar.topItem?.titleView = xxxcustomview
        self.tabBarController?.present(navigationVC, animated: true, completion: nil)
        //self.present(navigationVC, animated: true, completion: nil)
        
        UIView.animate(withDuration: 0.3) {
            self.Menubutton.transform = CGAffineTransform(scaleX: 8, y: 8)
        }
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            self.Menubutton.transform = .identity
        }, completion: nil)
    }
    @objc func CheckInButtonPressed()
    {
//        let xviewcontroller = CheckInPostVC()
//        let navigationVC = UINavigationController(rootViewController: xviewcontroller)
//        navigationVC.modalPresentationStyle = .overCurrentContext
//        self.present(navigationVC, animated: true, completion: nil)
        
//        let gg = GMSAutocompleteViewController()
//        gg.delegate = self
//        let navVC = UINavigationController(rootViewController: gg)
        
        let xgg = CheckInPostVC()
        let xnavVC = UINavigationController(rootViewController: xgg)
        
        //let autocompleteController = GMSAutocompleteViewController()
        //autocompleteController.delegate = self
        self.present(xnavVC, animated: true) {
            //
        }
        
        UIView.animate(withDuration: 0.3) {
            self.Menubutton.transform = CGAffineTransform(scaleX: 8, y: 8)
        }
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            self.Menubutton.transform = .identity
        }, completion: nil)
    }
}

    @available(iOS 9.0, *)
    extension NewPostVC: GMSAutocompleteViewControllerDelegate {
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
            
            let placename = place.name
            
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
            
            let vc = CheckInPostVC()
            navigationController?.pushViewController(vc, animated: true)
            
            //self.queryObjects()
            //self.dismiss(animated: true, completion: nil)
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

public class CustomGreenButton: UIButton {
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        //frame.size = CGSize(width: 100, height: 100)
        self.layer.cornerRadius = (self.frame.size.width/2)
        self.layer.masksToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

public class CustomStatusNavbarView: UIView
{
    var label: UILabel = UILabel()
    var GreenView: CustomView = CustomView()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        label.textAlignment = .left
        //label.font = UIFont.boldSystemFontOfSize(20.0)
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "Status"
        
        self.GreenView = CustomView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        self.label.frame.origin = self.frame.origin
        self.GreenView.frame.origin.x = self.label.frame.size.width
        self.GreenView.frame.origin.y = 0
        
        self.addSubview(label)
        self.addSubview(GreenView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class CustomCheckInNavbarView: UIView
{
    var label: UILabel = UILabel()
    var GreenView: CustomView = CustomView()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        label.textAlignment = .left
        //label.font = UIFont.boldSystemFontOfSize(20.0)
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "CheckIn"
        
        self.label.frame.origin = self.frame.origin
        
        self.addSubview(label)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class CustomGatheringNavbarView: UIView
{
    var label: UILabel = UILabel()
    var GreenView: CustomView = CustomView()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        label.textAlignment = .left
        //label.font = UIFont.boldSystemFontOfSize(20.0)
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.lightGray
        label.text = "Gathering"
        
        self.label.frame.origin = self.frame.origin
        
        self.addSubview(label)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class CustomPhotoNavbarView: UIView
{
    var label: UILabel = UILabel()
    var GreenView: CustomView = CustomView()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        label.textAlignment = .left
        //label.font = UIFont.boldSystemFontOfSize(20.0)
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "Photo"
        
        self.GreenView = CustomView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        self.label.frame.origin = self.frame.origin
        self.GreenView.frame.origin.x = self.label.frame.size.width
        self.GreenView.frame.origin.y = 0
        
        self.addSubview(label)
        self.addSubview(GreenView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class CustomView: UIView, CLLocationManagerDelegate
{
    var customButtonPresed = false
    
    var currentLoc = CLLocation()
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    var SmallCustomButtonbutton1: UIButton = {
        let SmallCustomButtonbutton = UIButton()
        SmallCustomButtonbutton.backgroundColor = UIColor.clear
        SmallCustomButtonbutton.frame.size = CGSize(width: 5, height: 5)
        SmallCustomButtonbutton.layer.cornerRadius = (SmallCustomButtonbutton.frame.size.width/2)
        SmallCustomButtonbutton.layer.masksToBounds = true
        //SmallCustomButtonbutton.addTarget(self, action: #selector(CustomButtonPressed), for: .touchUpInside)
        //CustomButtonbutton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 15)
        //CustomButtonbutton.setTitle("Custom", for: UIControlState.normal)
        return SmallCustomButtonbutton
    }()
    
    var SmallCustomButtonbutton2: UIButton = {
        let SmallCustomButtonbutton = UIButton()
        SmallCustomButtonbutton.backgroundColor = UIColor.clear
        SmallCustomButtonbutton.frame.size = CGSize(width: 5, height: 5)
        SmallCustomButtonbutton.layer.cornerRadius = (SmallCustomButtonbutton.frame.size.width/2)
        SmallCustomButtonbutton.layer.masksToBounds = true
        //SmallCustomButtonbutton.addTarget(self, action: #selector(CustomButtonPressed), for: .touchUpInside)
        //CustomButtonbutton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 15)
        //CustomButtonbutton.setTitle("Custom", for: UIControlState.normal)
        return SmallCustomButtonbutton
    }()
    
    var SmallCustomButtonbutton3: UIButton = {
        let SmallCustomButtonbutton = UIButton()
        SmallCustomButtonbutton.backgroundColor = UIColor.clear
        SmallCustomButtonbutton.frame.size = CGSize(width: 5, height: 5)
        SmallCustomButtonbutton.layer.cornerRadius = (SmallCustomButtonbutton.frame.size.width/2)
        SmallCustomButtonbutton.layer.masksToBounds = true
        //SmallCustomButtonbutton.addTarget(self, action: #selector(CustomButtonPressed), for: .touchUpInside)
        //CustomButtonbutton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 15)
        //CustomButtonbutton.setTitle("Custom", for: UIControlState.normal)
        return SmallCustomButtonbutton
    }()
    
    var SmallCustomButtonbutton4: UIButton = {
        let SmallCustomButtonbutton = UIButton()
        SmallCustomButtonbutton.backgroundColor = UIColor.clear
        SmallCustomButtonbutton.frame.size = CGSize(width: 5, height: 5)
        SmallCustomButtonbutton.layer.cornerRadius = (SmallCustomButtonbutton.frame.size.width/2)
        SmallCustomButtonbutton.layer.masksToBounds = true
        //SmallCustomButtonbutton.addTarget(self, action: #selector(CustomButtonPressed), for: .touchUpInside)
        //CustomButtonbutton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 15)
        //CustomButtonbutton.setTitle("Custom", for: UIControlState.normal)
        return SmallCustomButtonbutton
    }()
    
    var CustomButtonbutton = CustomGreenButton()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.CustomButtonbutton = CustomGreenButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        self.addSubview(CustomButtonbutton)
        self.addSubview(SmallCustomButtonbutton1)
        self.addSubview(SmallCustomButtonbutton2)
        self.addSubview(SmallCustomButtonbutton3)
        self.addSubview(SmallCustomButtonbutton4)
        
        self.CustomButtonbutton.addTarget(self, action: #selector(CustomButtonPressed), for: .touchUpInside)
        //CustomButtonbutton.center = CGPoint(x: self.view.frame.size.width/2, y: 135)
        SmallCustomButtonbutton1.center = CGPoint(x: CustomButtonbutton.center.x, y: CustomButtonbutton.center.y+(CustomButtonbutton.frame.size.width/2 + 5))
        SmallCustomButtonbutton2.center = CGPoint(x: CustomButtonbutton.center.x+(CustomButtonbutton.frame.size.width/2 + 5), y: CustomButtonbutton.center.y)
        SmallCustomButtonbutton3.center = CGPoint(x: CustomButtonbutton.center.x, y: CustomButtonbutton.center.y-(CustomButtonbutton.frame.size.width/2 + 5))
        SmallCustomButtonbutton4.center = CGPoint(x: CustomButtonbutton.center.x-(CustomButtonbutton.frame.size.width/2 + 5), y: CustomButtonbutton.center.y)
        
        CustomButtonbutton.layer.borderWidth = 3
        CustomButtonbutton.layer.borderColor = UIColor.lightGray.cgColor
        
        SmallCustomButtonbutton1.alpha = 0
        SmallCustomButtonbutton2.alpha = 0
        SmallCustomButtonbutton3.alpha = 0
        SmallCustomButtonbutton4.alpha = 0
        
        SmallCustomButtonbutton1.layer.borderWidth = 0.5
        SmallCustomButtonbutton1.layer.borderColor = UIColor.lightGray.cgColor
        SmallCustomButtonbutton2.layer.borderWidth = 0.5
        SmallCustomButtonbutton2.layer.borderColor = UIColor.lightGray.cgColor
        SmallCustomButtonbutton3.layer.borderWidth = 0.5
        SmallCustomButtonbutton3.layer.borderColor = UIColor.lightGray.cgColor
        SmallCustomButtonbutton4.layer.borderWidth = 0.5
        SmallCustomButtonbutton4.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.currentLoc = locations.last!
        
        print("Current Latitude \(self.currentLoc.coordinate.latitude)")
        print("Current Longitude \(self.currentLoc.coordinate.longitude)")
        
        self.locationManager.stopUpdatingLocation()
    }
    
    @objc func CustomButtonPressed()
    {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        doanimationshit()
    }
    
    func doanimationshit()
    {
        UIView.animate(withDuration: 0.5, animations: {
            if self.customButtonPresed == false
            {
                self.CustomButtonbutton.layer.borderWidth = 1
                self.CustomButtonbutton.layer.borderColor = UIColor.white.cgColor
                self.CustomButtonbutton.backgroundColor = UIColor.green
                
                self.SmallCustomButtonbutton1.alpha = 1
                self.SmallCustomButtonbutton2.alpha = 1
                self.SmallCustomButtonbutton3.alpha = 1
                self.SmallCustomButtonbutton4.alpha = 1
                
                self.DoBeatsAnimation()
                
                self.customButtonPresed = true
            }
            else
            {
                self.CustomButtonbutton.layer.borderWidth = 3
                self.CustomButtonbutton.layer.borderColor = UIColor.lightGray.cgColor
                self.CustomButtonbutton.backgroundColor = UIColor.clear
                
                self.SmallCustomButtonbutton1.alpha = 0
                self.SmallCustomButtonbutton2.alpha = 0
                self.SmallCustomButtonbutton3.alpha = 0
                self.SmallCustomButtonbutton4.alpha = 0
                
                self.SmallCustomButtonbutton1.backgroundColor = UIColor.clear
                self.SmallCustomButtonbutton2.backgroundColor = UIColor.clear
                self.SmallCustomButtonbutton3.backgroundColor = UIColor.clear
                self.SmallCustomButtonbutton4.backgroundColor = UIColor.clear
                
                self.customButtonPresed = false
            }
        }, completion: nil)
    }
    
    func DoBeatsAnimation()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.SmallCustomButtonbutton1.backgroundColor = UIColor.lightGray
            self.SmallCustomButtonbutton2.backgroundColor = UIColor.lightGray
            self.SmallCustomButtonbutton3.backgroundColor = UIColor.lightGray
            self.SmallCustomButtonbutton4.backgroundColor = UIColor.lightGray
        }) { (true) in
            self.SmallCustomButtonbutton1.backgroundColor = UIColor.clear
            self.SmallCustomButtonbutton2.backgroundColor = UIColor.clear
            self.SmallCustomButtonbutton3.backgroundColor = UIColor.clear
            self.SmallCustomButtonbutton4.backgroundColor = UIColor.clear
            UIView.animate(withDuration: 0.3, animations: {
                self.SmallCustomButtonbutton1.backgroundColor = UIColor.lightGray
                self.SmallCustomButtonbutton2.backgroundColor = UIColor.lightGray
                self.SmallCustomButtonbutton3.backgroundColor = UIColor.lightGray
                self.SmallCustomButtonbutton4.backgroundColor = UIColor.lightGray
            }, completion: { (true) in
                UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
//                    self.SmallCustomButtonbutton1.backgroundColor = UIColor.clear
//                    self.SmallCustomButtonbutton2.backgroundColor = UIColor.clear
//                    self.SmallCustomButtonbutton3.backgroundColor = UIColor.clear
//                    self.SmallCustomButtonbutton4.backgroundColor = UIColor.clear
                }, completion: { (true) in
                    UIView.animate(withDuration: 3, delay: 0, options: .curveEaseOut, animations: {
                        //print("DoShit")
                        self.SmallCustomButtonbutton1.alpha = 0
                        self.SmallCustomButtonbutton2.alpha = 0
                        self.SmallCustomButtonbutton3.alpha = 0
                        self.SmallCustomButtonbutton4.alpha = 0
                        
                    }, completion: { (true) in
                        //self.DoBeatsAnimation()
                        //print("GG")
                    })
                })
            })
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol whichGatheringSelectedDelegator {
    func whichGatheringIsSelected(_ gathering: Gathering?)
}

protocol checkifPostPressedDelegator {
    func checkIfPostIsPressed(_ trueOrFalse: Bool)
}

public class somexview: UIView, checkifImageSelectedDelegator
{

    var scrollView = UIScrollView()
    
    //var arrayOfGatheringObjects = [Gathering]()
    
    var arrayOfGatheringObjects: [Gathering]! {
        didSet {
            self.DoSomethingWithGatheringObjects()
        }
    }
    
    var delegate: whichGatheringSelectedDelegator!
    var postButtonDelegate: checkifPostPressedDelegator!
    
    var theSelectedGathering = Gathering()
    
    var Noneggsomeview = statusvcgatheringview()
    var ggsomeview1 = statusvcgatheringview()
    var ggsomeview2 = statusvcgatheringview()
    var ggsomeview3 = statusvcgatheringview()
    var ggsomeview4 = statusvcgatheringview()
    var ggsomeview5 = statusvcgatheringview()
    var arrayOfSomeShit = [statusvcgatheringview]()
    
    var CancelButton = FLoatingButton()
    var PostButton = FLoatingButton()
    
    var isItInCheckIn = true
    
    var nameLabel = UILabel()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        let widthOfview = self.frame.size.width/5
        //self.addSubview(postimageView)
        
        if isItInCheckIn == true
        {
            self.nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 25))
            self.nameLabel.text = "Or you can choose a gathering"
            self.nameLabel.textAlignment = .center
            self.nameLabel.font = UIFont(name: "HelveticaNeue", size: 13)
            self.nameLabel.textColor = UIColor.lightGray
            self.addSubview(nameLabel)
        }
        else
        {
            self.nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 25))
            self.nameLabel.text = "Choose a gathering"
            self.nameLabel.font = UIFont(name: "HelveticaNeue", size: 13)
            self.nameLabel.textColor = UIColor.lightGray
            self.addSubview(nameLabel)
        }
        
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 25, width: self.frame.size.width, height: self.frame.size.height-25-30))
        self.scrollView.backgroundColor = UIColor.white
        self.scrollView.alwaysBounceHorizontal = true
        self.scrollView.contentSize = CGSize(width: self.frame.size.width+widthOfview, height: self.frame.size.height-25-30)
        self.addSubview(scrollView)
        
        let xheight = self.frame.size.height-(self.scrollView.frame.size.height+25)
//        self.CancelButton = FLoatingButton(frame: CGRect(x: 0, y: self.scrollView.frame.size.height+25, width: self.frame.size.width/2, height: xheight))
//        self.CancelButton.backgroundColor = UIColor.green
//        self.CancelButton.setTitle("Cancel", for: .normal)
//        self.CancelButton.setTitleColor(UIColor.white, for: .normal)
//        self.CancelButton.layer.cornerRadius = 5
//        self.addSubview(CancelButton)
        
        self.PostButton = FLoatingButton(frame: CGRect(x: 0, y: self.scrollView.frame.size.height+25, width: self.frame.size.width, height: xheight))
        self.PostButton.backgroundColor = UIColor(hex: "2259B2")
        self.PostButton.setTitle("Post", for: .normal)
        self.PostButton.setTitleColor(UIColor.white, for: .normal)
        self.PostButton.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
        self.PostButton.layer.cornerRadius = 5
        self.addSubview(PostButton)
        
        self.arrayOfSomeShit.append(Noneggsomeview)
        self.arrayOfSomeShit.append(ggsomeview1)
        self.arrayOfSomeShit.append(ggsomeview2)
        self.arrayOfSomeShit.append(ggsomeview3)
        self.arrayOfSomeShit.append(ggsomeview4)
        self.arrayOfSomeShit.append(ggsomeview5)
        
        //let widthOfview = self.frame.size.width/5
        
        for var i in 0..<6 {
            let l = CGFloat(i)
            //print(l)
            //self.scrollView.addSubview(arrayOfSomeShit[i])
            self.arrayOfSomeShit[i] = statusvcgatheringview(frame: CGRect(x: l+(widthOfview*l), y: 0, width: widthOfview, height: self.frame.size.height))
            self.arrayOfSomeShit[i].delegate = self
            //arrayOfSomeShit[i].gathering = self.arrayOfGatheringObjects[i]
            //print(self.arrayOfGatheringObjects[i].nameGathering)
            print(widthOfview*l)
            self.scrollView.addSubview(arrayOfSomeShit[i])
        }
    }
    
    func cancelButtonPressed()
    {
        
    }
    
    @objc func postButtonPressed()
    {
        print("post button pressed")
        self.postButtonDelegate.checkIfPostIsPressed(true)
    }
    
    func deselectAllExceptNone()
    {
        for var i in 0..<6 {
            if (i==0)
            {
                self.arrayOfSomeShit[i].isThisImageSelected = false
                //self.arrayOfSomeShit[i].updateUI()
                print("Inner loop")
            }
            else
            {
                self.arrayOfSomeShit[i].isThisImageSelected = true
                //self.arrayOfSomeShit[i].updateUI()
                print("Inner loop")
            }
        }
    }
    
    func deselectAllExceptThis(_ statusvcgv: statusvcgatheringview) {
        
        for var i in 0..<6 {
            self.arrayOfSomeShit[i].isThisImageSelected = true
            //self.arrayOfSomeShit[i].updateUI()
            print("Inner loop")
        }
        
        let yolo = statusvcgv
        yolo.isThisImageSelected = false
        
        if yolo.gathering != nil
        {
            self.delegate.whichGatheringIsSelected(yolo.gathering)
        }
        else
        {
            self.delegate.whichGatheringIsSelected(nil)
        }
        
        print("outer loop")
    }
    
    func DoSomethingWithGatheringObjects()
    {
        arrayOfSomeShit[0].isit = true
        arrayOfSomeShit[0].isThisImageSelected = false
        for var i in 1..<6 {
            arrayOfSomeShit[i].gathering = self.arrayOfGatheringObjects[i-1]
            arrayOfSomeShit[i].isit = true
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol checkifImageSelectedDelegator {
    func deselectAllExceptThis(_ statusvcgv: statusvcgatheringview)
}

public class statusvcgatheringview: UIView
{
    
    //var height: CGFloat!
    var PostimageView: UIImageView = {
        let postimageView = UIImageView()
        postimageView.contentMode = .scaleAspectFill
        postimageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return postimageView
    }()
    
    var nameLabel: UILabel!
    
    var gathering: Gathering? {
        didSet {
            //self.updateUI()
        }
    }
    
    var delegate: checkifImageSelectedDelegator!
    
    var isit: Bool! {
        didSet {
            self.whatever()
        }
    }
    
    var someImageView = PFImageView()
    var textLabel = UILabel()
    
    var isThisImageSelected: Bool? {
        didSet {
            self.updateUI()
        }
    }
    
    var tpgesture = UITapGestureRecognizer()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        let width = self.frame.size.width
        
        self.someImageView = PFImageView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        //self.someImageView.image = UIImage(named: "Dota")
        self.someImageView.clipsToBounds = true
        self.someImageView.layer.cornerRadius = width/2
        self.someImageView.contentMode = UIViewContentMode.scaleAspectFill
        self.someImageView.layer.backgroundColor = UIColor.yellow.cgColor
        self.someImageView.layer.borderWidth = 1
        self.someImageView.layer.borderColor = UIColor.gray.cgColor
        self.someImageView.isUserInteractionEnabled = true
        self.addSubview(someImageView)
        
        self.tpgesture = UITapGestureRecognizer(target: self, action: #selector(ImageTapped))
        tpgesture.numberOfTapsRequired = 1
        self.someImageView.addGestureRecognizer(tpgesture)
        
        self.nameLabel = UILabel(frame: CGRect(x: 0, y: width, width: width, height: 20))
        nameLabel.textColor = UIColor.black
        nameLabel.backgroundColor = UIColor.clear
        nameLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        nameLabel.textAlignment = .center
        self.nameLabel.text = self.gathering?.nameGathering
        self.addSubview(nameLabel)
        
    }
    
    @objc func ImageTapped()
    {
        self.delegate.deselectAllExceptThis(self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func whatever()
    {
        //print(self.gathering.nameGathering)
        //self.someImageView.image = UIImage(named: "Dota")
                if self.gathering?.imageGathering != nil
                {
                    someImageView.file = self.gathering?.imageGathering
                    self.nameLabel.text = self.gathering?.nameGathering
        
                    self.someImageView.load(inBackground: { (image, error) in
        
                    }, progressBlock: { (number) in
                        print(number)
                    })
                }
                else
                {
                    self.nameLabel.textColor = UIColor.lightGray
                    self.nameLabel.text = "None"
                    self.someImageView.layer.backgroundColor = UIColor.lightGray.cgColor
                    self.someImageView.backgroundColor = UIColor.lightGray
                }
    }
    
    func updateUI()
    {
        print("Image Tapped")
        if self.isThisImageSelected == false
        {
            //self.isThisImageSelected = true
            self.someImageView.layer.borderWidth = 5
            self.someImageView.layer.borderColor = UIColor(hex: "2259B2").cgColor
        }
        else
        {
            //self.isThisImageSelected = false
            self.someImageView.layer.borderWidth = 1
            self.someImageView.layer.borderColor = UIColor.gray.cgColor
        }
    }
}

class StatusPostVC: UIViewController, UITextViewDelegate, SelectedImageDelegator, CLLocationManagerDelegate, whichGatheringSelectedDelegator, checkifPostPressedDelegator
{
    var CancelBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    var PostBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    var textView = UITextView()
    var label = UILabel()
    var isLocationOn = false
    var imageView = UIImageView()
    var plusbutton = FLoatingButton()
    var currentLoc: CLLocation?
    var activityIndicator = UIActivityIndicatorView()
    var locationManager: CLLocationManager = CLLocationManager()
    var arrayOfGatheringObjects = [Gathering]()
    
    var xview: somexview!
    
    var somefadedBlackView = UIView()
    
    var someScrollView: UIScrollView!
    
    var PFlocation: PFGeoPoint!
    
    var theSelectedGathering: Gathering?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        
        CancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelButtonPressed))
        self.navigationItem.leftBarButtonItem = CancelBarButtonItem
        
        PostBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(PostButtonPressed))
        self.navigationItem.rightBarButtonItem = PostBarButtonItem
        
        self.textView = UITextView(frame: CGRect(x: 10.0, y: 10.0, width: self.view.frame.size.width - 20, height: 100.0))
        //self.automaticallyAdjustsScrollViewInsets = false
        
        textView.textAlignment = NSTextAlignment.left
        textView.backgroundColor = UIColor(white: 0, alpha: 0.1)
        textView.layer.cornerRadius = 5
        textView.text = "Write Something"
        textView.textColor = UIColor.lightGray
        textView.font = UIFont(name: "HelveticaNeue", size: 13)
        textView.delegate = self
        self.view.addSubview(textView)
        
        self.label = UILabel(frame: CGRect(x: 10, y: 120, width: self.view.frame.size.width - 20, height: 20))
        self.label.textAlignment = .center
        self.label.text = "Post a picture along?"
        self.label.font = UIFont(name: "HelveticaNeue", size: 14)
        self.view.addSubview(label)
        
        self.imageView = UIImageView(frame: CGRect(x: 10, y: 150, width: self.view.frame.size.width - 20, height: self.view.frame.size.width - 20))
        self.imageView.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.isUserInteractionEnabled = true
        self.view.addSubview(imageView)
        
        self.plusbutton = FLoatingButton(frame: CGRect(x:  (self.imageView.frame.size.width/2) - 15, y: (self.imageView.frame.size.width/2) - 15, width: 30, height: 30))
        self.plusbutton.setImage(UIImage(named: "plusicon"), for: UIControlState.normal)
        self.plusbutton.isUserInteractionEnabled = true
        //self.plusbutton.target(forAction: #selector(PlusButtonPressed), withSender: self)
        self.plusbutton.addTarget(self, action: #selector(self.PlusButtonPressed), for: .touchUpInside)
        self.imageView.addSubview(plusbutton)
        
        self.somefadedBlackView = UIView()
        //self.somefadedBlackView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.somefadedBlackView.frame = (self.navigationController?.view.frame)!
        self.somefadedBlackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let tpxx = UITapGestureRecognizer(target: self, action: #selector(blackViewClicked))
        tpxx.numberOfTapsRequired = 1
        self.somefadedBlackView.addGestureRecognizer(tpxx)
        
        self.locationManager.delegate = self
        
        self.queryGatheringObjects()
        print(self.arrayOfGatheringObjects.count)

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
        //it was 122 not 152 but it works-------->
        self.xview = somexview(frame: CGRect(x: 0, y: self.navigationController!.view.frame.size.height, width: self.view.frame.size.width, height: 152))
        //print(self.arrayOfGatheringObjects)
        xview.arrayOfGatheringObjects = self.arrayOfGatheringObjects
        xview.delegate = self
        xview.postButtonDelegate = self
        //xview.backgroundColor = UIColor.blue
        self.navigationController?.view.addSubview(xview)
    }
    
    func SelectedImage(_ image: UIImage) {
        self.imageView.image = image
        self.plusbutton.removeFromSuperview()
    }
    
    @objc func PlusButtonPressed()
    {
        print("Plus Button Pressed")
        let layout = UICollectionViewFlowLayout()
        let vc = PhotoSelectorController(collectionViewLayout: layout)
        vc.isAstatuspost = true
        vc.delegate = self
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.modalPresentationStyle = .overCurrentContext
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
        if textView.textColor == UIColor.lightGray
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
            textView.textColor = UIColor.lightGray
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func PostButtonPressed()
    {
        self.showHideGatheringsView()
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
    
    var isGatheringsViewShown = false
    
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
    
    func SecondPartOfPostButtonPressed()
    {
        print("Post pressed")
        //self.navigationController?.dismiss(animated: true, completion: nil)
        
        let ggView = navigationController?.navigationBar.topItem?.titleView as! CustomStatusNavbarView
        let someethigngdfs = ggView.GreenView.customButtonPresed
        if someethigngdfs == true
        {
            let gg = ggView.GreenView.currentLoc
            let xcurrentLoc = PFGeoPoint(location: gg)
            
            print(xcurrentLoc)
            if self.imageView.image != nil
            {
                let some = UIImageJPEGRepresentation(self.imageView.image!, 1)
                //let imageData = UIImagePNGRepresentation(self.imageView.image!)
                let imageFile = PFFile(name: "image.png", data: some!)
                let xPost = Post(shares: self.textView.text, userID: PFUser.current()!.objectId!, xImageFile: imageFile, numberOfLikes: 0, xlocation: xcurrentLoc, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: false, locationName: "", numberIfLocation: 0, numberIfStatus: 1, numberIfPhoto: 0, numberIfCheckIn: 0, isMapShown: 0, gathering: theSelectedGathering)
                
                xPost.saveInBackground { (success, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    //self.locationManager.stopUpdatingLocation()
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    
                    if error == nil
                    {
                        //self.ImageToPost?.image = UIImage(named: "wow.png")
                        //self.Opinion.text = ""
                        self.displayAlert("Posted", message: "Your Status has been posted successfully")
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
                let xPost = Post(shares: self.textView.text, userID: PFUser.current()!.objectId!, xImageFile: nil, numberOfLikes: 0, xlocation: xcurrentLoc, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: false, locationName: "", numberIfLocation: 0, numberIfStatus: 1, numberIfPhoto: 0, numberIfCheckIn: 0, isMapShown: 0, gathering: theSelectedGathering)
                
                xPost.saveInBackground { (success, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    //self.locationManager.stopUpdatingLocation()
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    
                    if error == nil
                    {
                        //self.ImageToPost?.image = UIImage(named: "wow.png")
                        //self.Opinion.text = ""
                        self.displayAlert("Posted", message: "Your Status has been posted successfully")
                    }
                    else
                    {
                        print(error?.localizedDescription as Any)
                        self.displayAlert("Could not post image", message: "Please try again later")
                    }
                }
            }
        }
        else
        {
            //spvc.isLocationOn = false
            if self.imageView.image != nil
            {
                let some = UIImageJPEGRepresentation(self.imageView.image!, 1)
                //let imageData = UIImagePNGRepresentation(self.imageView.image!)
                let imageFile = PFFile(name: "image.png", data: some!)
                let xPost = Post(shares: self.textView.text, userID: PFUser.current()!.objectId!, xImageFile: imageFile, numberOfLikes: 0, xlocation: nil, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: false, locationName: "", numberIfLocation: 0, numberIfStatus: 1, numberIfPhoto: 0, numberIfCheckIn: 0, isMapShown: 0, gathering: theSelectedGathering)
                
                xPost.saveInBackground { (success, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    //self.locationManager.stopUpdatingLocation()
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    
                    if error == nil
                    {
                        //self.ImageToPost?.image = UIImage(named: "wow.png")
                        //self.Opinion.text = ""
                        self.displayAlert("Posted", message: "Your Status has been posted successfully")
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
                let xPost = Post(shares: self.textView.text, userID: PFUser.current()!.objectId!, xImageFile: nil, numberOfLikes: 0, xlocation: nil, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: false, locationName: "", numberIfLocation: 0, numberIfStatus: 1, numberIfPhoto: 0, numberIfCheckIn: 0, isMapShown: 0, gathering: theSelectedGathering)
                
                xPost.saveInBackground { (success, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    //self.locationManager.stopUpdatingLocation()
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    
                    if error == nil
                    {
                        //self.ImageToPost?.image = UIImage(named: "wow.png")
                        //self.Opinion.text = ""
                        self.displayAlert("Posted", message: "Your Status has been posted successfully")
                    }
                    else
                    {
                        print(error?.localizedDescription as Any)
                        self.displayAlert("Could not post image", message: "Please try again later")
                    }
                }
            }
        }
    }
    
    func displayAlert(_ title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.navigationController?.dismiss(animated: true, completion: nil)
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

class PhotoPostVC: UIViewController
{
    var CancelBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    var PostBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        CancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelButtonPressed))
        self.navigationItem.leftBarButtonItem = CancelBarButtonItem
        
        PostBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(PostButtonPressed))
        self.navigationItem.rightBarButtonItem = PostBarButtonItem
        
    }
    
    @objc func PostButtonPressed()
    {
        print("Post pressed")
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func CancelButtonPressed()
    {
        print("Cancel pressed")
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

class FLoatingButton: UIButtonX
{
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        alphaBefore = alpha
        
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0.4
        })
        
        return true
    }
}
