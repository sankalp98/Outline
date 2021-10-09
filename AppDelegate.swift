//
//  AppDelegate.swift
//  Outline
//
//  Created by Sankalp on 15/07/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI
import GoogleMaps
import IGListKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IGComment.registerSubclass()
        User.registerSubclass()
        Post.registerSubclass()
        Comment.registerSubclass()
        Activity.registerSubclass()
        
        //Parse.setApplicationId("w3KZZa7lZO5CEB6IVCXtGrx2ixcfm3SZf7ijrEUS", clientKey: "1lleVtHID9pMIIOkuQMoHDxkWPjLM9N1CnKe9oBn")
        
        let config = ParseClientConfiguration(block: {
            (ParseMutableClientConfiguration) -> Void in
            ParseMutableClientConfiguration.applicationId = "w3KZZa7lZO5CEB6IVCXtGrx2ixcfm3SZf7ijrEUS";
            ParseMutableClientConfiguration.clientKey = "1lleVtHID9pMIIOkuQMoHDxkWPjLM9N1CnKe9oBn";
            //ParseMutableClientConfiguration.server = "https://appnumber1.herokuapp.com/parse";
            ParseMutableClientConfiguration.server = "https://yolo1234.herokuapp.com/parse";
            ParseMutableClientConfiguration.isLocalDatastoreEnabled = true
        });
        //Parse.enableLocalDatastore()
        Parse.initialize(with: config);

        
        GMSServices.provideAPIKey("AIzaSyCfYcNIZKufGoTKU_b4eU67EVF1C-VjdS4")
        
        UINavigationBar.appearance().isOpaque = true
        UINavigationBar.appearance().barTintColor = UIColor(red: 34, green: 89, blue: 178, alpha: 1)
        //self.setStatusBarBackgroundColor(color: UIColor(hex: "2259B2"))
        
        let initialvc = TestViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = initialvc
        
        /*var nOfFollowings = User.currentUser()!.xnumberOfFollowings
        nOfFollowings = 0
        User.currentUser()!.xnumberOfFollowings = nOfFollowings
        User.currentUser()!.saveInBackgroundWithBlock({ (success, error) in
            if error == nil
            {
                if success == true
                {
                    print("YOLO")
                }
            }
            else
            {
                print("Error occured , could not increase Followings")
            }
        })*/
        
        //UINavigationBar.appearance().barTintColor = UIColor.rgb(230, green: 32, blue: 31)
        
        application.statusBarStyle = UIStatusBarStyle.default

        //UIColor(red: 34, green: 89, blue: 178, alpha: 1)
        //UIColor(hex: "2259B2")
        
//        let statusBarBackgroundView = UIView()
//        statusBarBackgroundView.backgroundColor = UIColor(red: 34, green: 89, blue: 178, alpha: 1)
//        window!.backgroundColor = UIColor(red: 34, green: 89, blue: 178, alpha: 1)
//        window!.addSubview(statusBarBackgroundView)
//        statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
//        window!.addConstraintsWithFormat("H:|[v0]|", views: statusBarBackgroundView)
//        window!.addConstraintsWithFormat("V:|[v0(20)]", views: statusBarBackgroundView)
        
        //+ (instancetype)objectWithoutDataWithObjectId:(nullable NSString *)objectId;
        
        
        return true
        
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        
        statusBar.backgroundColor = color
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class GradientView: UIView {
    
    override class var layerClass : AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 130)
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        gradient.locations = [-0.2 , 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.opacity = 10
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

