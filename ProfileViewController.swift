//
//  ProfileViewController.swift
//  BaeToBye
//
//  Created by Apple on 15/07/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var MainScrollView: UIScrollView!
    
    @IBOutlet weak var PostsTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var postsContainerView: UIView!
    
    @IBOutlet weak var postsContViewHeightConstraint: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var StatusTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var StatusTableView: UITableView!
    @IBOutlet weak var PostsTableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var postsLabel: UILabel = UILabel()
    
    var askoutsLabel: UILabel = UILabel()
    
    var followingLabel: UILabel = UILabel()
    
    var numberOfPostsLabel: UILabel = UILabel()
    
    var numberOfAskoutsLabel:UILabel = UILabel()
    
    var numberOfFollowingLabel:UILabel = UILabel()
    
    var profilePictureImageView: UIImageView = UIImageView()
    
    @IBOutlet weak var InfoLabel: UILabel!
    
    @IBOutlet weak var CoverPictureImageView: UIImageView!
    
    @IBOutlet weak var InfoUpperConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        segmentControl.selectedSegmentIndex = 0
        //self.PostsTableView.hidden = false
        //self.StatusTableView.hidden = true
        self.MainScrollView.alwaysBounceVertical = true
        
        //self.view.addSubview(postsContainerView)
        print("ViewDidLoad")
        
        self.CoverPictureImageView.clipsToBounds = true
        
        self.InfoLabel.text = "Through the milky way, in my spaceship, at the speed of light I'm gonna make it!"
        
        self.MainScrollView.addSubview(profilePictureImageView)
        self.profilePictureImageView.frame = CGRectMake(0, self.CoverPictureImageView.frame.size.height-55, 110, 110)
        self.profilePictureImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.profilePictureImageView.image = UIImage(named: "lolwa.png")
        profilePictureImageView.layer.borderWidth = 1.5
        profilePictureImageView.layer.masksToBounds = false
        profilePictureImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.size.width/2
        profilePictureImageView.clipsToBounds = true
        
        self.MainScrollView.addSubview(postsLabel)
        self.postsLabel.frame = CGRectMake(self.profilePictureImageView.frame.size.width+3, self.CoverPictureImageView.frame.size.height+(self.profilePictureImageView.frame.size.height/2)-25, 40, 20)
        self.postsLabel.text = "Posts"
        self.postsLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        self.postsLabel.textColor = UIColor.grayColor()
        //self.postsLabel.backgroundColor = UIColor.yellowColor()
        
        self.MainScrollView.addSubview(followingLabel)
        self.followingLabel.frame = CGRectMake(self.view.frame.size.width - 70, self.CoverPictureImageView.frame.size.height+(self.profilePictureImageView.frame.size.height/2)-25, 65, 20)
        self.followingLabel.text = "Following"
        self.followingLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        self.followingLabel.textColor = UIColor.grayColor()
        //self.followingLabel.backgroundColor = UIColor.yellowColor()
        
        self.MainScrollView.addSubview(askoutsLabel)
        self.askoutsLabel.frame.size = CGSizeMake(55, 20)
        self.askoutsLabel.center = CGPointMake((self.postsLabel.center.x+self.followingLabel.center.x)/2, self.postsLabel.center.y)
        self.askoutsLabel.text = "AskOuts"
        self.askoutsLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        self.askoutsLabel.textColor = UIColor.grayColor()
        //self.askoutsLabel.backgroundColor = UIColor.yellowColor()
        
        self.MainScrollView.addSubview(numberOfPostsLabel)
        self.numberOfPostsLabel.frame.size = CGSizeMake(28, 20)
        let middlex = self.postsLabel.center.x
        //self.numberOfPostsLabel.frame.origin = CGPointMake(middlex, self.postsLabel.frame.origin.y-20)
        let nana = (self.postsLabel.frame.origin.y-self.CoverPictureImageView.frame.size.height)/2
        self.numberOfPostsLabel.center.x = middlex
        self.numberOfPostsLabel.center.y = self.CoverPictureImageView.frame.size.height + nana
        self.numberOfPostsLabel.text = "529"
        self.numberOfPostsLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        self.numberOfPostsLabel.textColor = UIColor.blackColor()
        //self.numberOfPostsLabel.backgroundColor = UIColor.yellowColor()
        
        self.MainScrollView.addSubview(numberOfAskoutsLabel)
        self.numberOfAskoutsLabel.frame.size = CGSizeMake(34, 20)
        let middlexx = self.askoutsLabel.center.x
        //self.numberOfPostsLabel.frame.origin = CGPointMake(middlex, self.postsLabel.frame.origin.y-20)
        let nana1 = (self.postsLabel.frame.origin.y-self.CoverPictureImageView.frame.size.height)/2
        self.numberOfAskoutsLabel.center.x = middlexx
        self.numberOfAskoutsLabel.center.y = self.CoverPictureImageView.frame.size.height + nana1
        self.numberOfAskoutsLabel.text = "1.5M"
        self.numberOfAskoutsLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        self.numberOfAskoutsLabel.textColor = UIColor.blackColor()
        //self.numberOfAskoutsLabel.backgroundColor = UIColor.yellowColor()
        
        self.MainScrollView.addSubview(numberOfFollowingLabel)
        self.numberOfFollowingLabel.frame.size = CGSizeMake(19, 20)
        let middlexxx = self.followingLabel.center.x
        //self.numberOfPostsLabel.frame.origin = CGPointMake(middlex, self.postsLabel.frame.origin.y-20)
        let nana2 = (self.postsLabel.frame.origin.y-self.CoverPictureImageView.frame.size.height)/2
        self.numberOfFollowingLabel.center.x = middlexxx
        self.numberOfFollowingLabel.center.y = self.CoverPictureImageView.frame.size.height + nana2
        self.numberOfFollowingLabel.text = "29"
        self.numberOfFollowingLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        self.numberOfFollowingLabel.textColor = UIColor.blackColor()
        //self.numberOfFollowingLabel.backgroundColor = UIColor.yellowColor()
        
        // turn off the current selection
        //segmentControl.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //self.MainScrollView.contentSize.height = 1000
        
        //self.PostsTableView.scrollEnabled = false
        //self.StatusTableView.scrollEnabled = false
        //self.StatusTableView.scrollEnabled = false
        self.MainScrollView.scrollEnabled = true
        let gg1 = self.segmentControl.frame.origin.y
        let ggheight = self.segmentControl.frame.size.height
        _ = gg1 + ggheight
        //self.MainScrollView.contentSize.height = self.PostsTableView.contentSize.height + hola
        //self.MainScrollView.contentSize.height = self.postsContainerView.subviews.last.contentSize.height
        //self.askoutsLabel.center.x = (self.postsLabel.center.x+self.followingLabel.center.x)/2
        //self.askoutsLabel.center.y = self.postsLabel.center.y
        
        //var hoga = self.postsLabel.frame.origin.y - self.CoverPictureImageView.frame.size.height + self.postsLabel.frame.size.height
        
        let hoga = (self.profilePictureImageView.frame.size.height)/2 + 10
        self.InfoUpperConstraint.constant = hoga
        
        //self.PostsTableViewHeightConstraint.constant = self.PostsTableView.contentSize.height
        //self.postsContViewHeightConstraint.constant = self.postsContainerView.subviews.last!.contentSize.height
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        //println(self.PostsTableView.contentSize.height)
        //self.PostsTableViewHeightConstraint.constant = self.PostsTableView.contentSize.height
        //self.postsContViewHeightConstraint.constant = self.postsContainerView.subviews.last!.contentSize.height
        let gg1 = self.segmentControl.frame.origin.y
        let ggheight = self.segmentControl.frame.size.height
        _ = gg1 + ggheight
        //self.MainScrollView.contentSize.height = self.postsContainerView.subviews.last!.contentSize.height + hola
    }
    
    
    
    @IBAction func segmentValueChanged(sender: AnyObject) {
        
        
        if sender.selectedSegmentIndex == 0
        {
            //self.MainScrollView.addSubview(PostsTableView)
            //self.PostsTableView.hidden = false
            //self.StatusTableView.hidden = true
            let gg1 = self.segmentControl.frame.origin.y
            let ggheight = self.segmentControl.frame.size.height
            _ = gg1 + ggheight
            //self.MainScrollView.contentSize.height = self.postsContainerView.subviews.last!.contentSize.height + hola
            
            //self.StatusTableView.removeFromSuperview()
        }
        else if sender.selectedSegmentIndex == 1
        {
            
            //self.PostsTableView.hidden = true
            //self.StatusTableView.hidden = false
            let gg1 = self.segmentControl.frame.origin.y
            let ggheight = self.segmentControl.frame.size.height
            _ = gg1 + ggheight
            //self.MainScrollView.addSubview(StatusTableView)
            //self.MainScrollView.contentSize.height = self.postsContainerView.subviews.last!.contentSize.height + hola
            //self.MainScrollView.contentInset.bottom = 310
            //self.postsContViewHeightConstraint.constant = self.postsContainerView.subviews.last!.contentSize.height
            //self.PostsTableView.removeFromSuperview()
        }
        else
        {
            print("Photos")
        }
        
        
        
    }
    
    /*@IBAction func LogoutButtonPressed(sender: AnyObject) {
        println("User Logged Out")
        
        PFUser.logOut()
        
        let mainVC: UIViewController = storyboard?.instantiateInitialViewController() as! UIViewController
        self.presentViewController(mainVC, animated: true, completion: nil)
        
    }*/

}
