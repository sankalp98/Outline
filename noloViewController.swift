//
//  noloViewController.swift
//  BaeToBye
//
//  Created by Apple on 16/09/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

import UIKit

class noloViewController: UITabBarController {

    //@IBOutlet weak var myTabBar: UITabBar!
    
    
    
    
    
    /*override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedViewController = FeedsPFQueryTVC()
        //var navController = UINavigationController(rootViewController: feedViewController)
        var navgg = UINavigationController(nibName: "nav1", bundle: nil)
        navgg.title = "News Feed"
        navgg.tabBarItem.image = UIImage(named: "")
        
        
    }*/
    
    /*- (void)viewWillLayoutSubviews
    {
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = 80;
    tabFrame.origin.y = self.view.frame.size.height - 80;
    self.tabBar.frame = tabFrame;
    }*/
    
    override func viewWillLayoutSubviews() {
        var tabFrame: CGRect = self.tabBar.frame
        tabFrame.size.height = 45
        tabFrame.origin.y = self.view.frame.size.height - 45
        self.tabBar.frame = tabFrame
        print(tabFrame.size.width)
    }

    
    override func viewDidLoad() {
            // Sets the default color of the icon of the selected UITabBarItem and Title
            UITabBar.appearance().tintColor = UIColor.white
        
        let vc1 = FeedsIGListViewController()
        let navvc1 = UINavigationController(rootViewController: vc1)
        navvc1.title = "Feed"
        
        let splitViewController =  UISplitViewController()
        let homeViewController = IGNewNearbyVC()
        let secondViewController = DestinationVC()
        let homeNavigationController = UINavigationController(rootViewController:homeViewController)
        let secondNavigationController = UINavigationController(rootViewController:secondViewController)
        splitViewController.viewControllers = [homeNavigationController,secondNavigationController]
        splitViewController.title = "Nearby"
        
//        let vc2 = IGNearbyVC()
//        let navvc2 = UINavigationController(rootViewController: vc2)
//        navvc2.title = "Nearby"
        
        let vc3 = NewPostVC()
        let navvc3 = UINavigationController(rootViewController: vc3)
        navvc3.title = "Post"
        
        let vc4 = UIViewController()
        vc4.view.backgroundColor = UIColor.white
        let navvc4 = UINavigationController(rootViewController: vc4)
        navvc4.title = "Notifs"
        
        let vc5 = IGListProfileVC()
        let navvc5 = UINavigationController(rootViewController: vc5)
        navvc5.title = "Profile"
        
        viewControllers = [navvc1, splitViewController, navvc3, navvc4, navvc5]
        
        print("GG")
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = UIColor(hex: "15191F")
        //UIColor(hex: "15191F")
        // Sets the background color of the selected UITabBarItem (using and plain colored UIImage with the width = 1/5 of the tabBar (if you have 5 items) and the height of the tabBar)
        //UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(UIColor(hex: "272727"), size: CGSize(width: tabBar.frame.width/5, height: 45))
        
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) -> Bool {
        
        viewController.viewDidAppear(true)
        
        return true
        
        
        
    }
    


}

extension UIImage {
    func makeImageWithColorAndSize(_ color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
