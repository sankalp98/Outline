//
//  4.swift
//  Outline
//
//  Created by Apple on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

protocol NewMyCustomCellDelegator {
    func callSegueFromCell(_ post: Post)
}

protocol gatheringButtonClickedDelegator: class
{
    func GoToTheSelectedGathering(_ gathering: Gathering)
}

protocol someFuckAllDelegator {
    func doSomething(_ post: Post)
}

class LikeButtonCell: UICollectionViewCell
{
    var post: Post! {
        didSet {
            self.updateUI()
        }
    }
    
    var delegate:NewMyCustomCellDelegator!
    var xdelegate:someFuckAllDelegator!
    
    var gatheringDelegate:gatheringButtonClickedDelegator!
    
    var gatheringimageView: PFImageView = {
        let imageView = PFImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1).cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var LikeButton:UIButton = UIButton()
    var CommentButton: UIButton = UIButton()
    
    var tpGesture = UITapGestureRecognizer()
    
    func updateUI()
    {
        
        self.addSubview(LikeButton)
        LikeButton.translatesAutoresizingMaskIntoConstraints = false
        //LikeButton.addTarget(self, action: #selector(BigCell.LikeButtonPressed), for: .touchUpInside)
        LikeButton.contentMode = UIViewContentMode.scaleAspectFit
        LikeButton.clipsToBounds = true
        LikeButton.setImage(UIImage(named: "UnLiked.png"), for: UIControlState())
        
        self.addSubview(CommentButton)
        CommentButton.translatesAutoresizingMaskIntoConstraints = false
        CommentButton.addTarget(self, action: #selector(self.CommentButtonPressed), for: .touchUpInside)
        CommentButton.setImage(UIImage(named: "OutlineComment.png"), for: UIControlState())
        CommentButton.clipsToBounds = true
        CommentButton.contentMode = UIViewContentMode.scaleAspectFit
        
        gatheringimageView.translatesAutoresizingMaskIntoConstraints = false
        self.gatheringimageView.isUserInteractionEnabled = true
        self.tpGesture = UITapGestureRecognizer(target: self, action: #selector(self.GatheringImageClicked))
        self.tpGesture.numberOfTapsRequired = 1
        self.gatheringimageView.addGestureRecognizer(self.tpGesture)
        
        addConstraintsWithFormat("H:|-10-[v0(27)]-10-[v1(27)]", views: LikeButton, CommentButton)
        
        addConstraintsWithFormat("V:|-5-[v0(27)]-5-|", views: LikeButton)
        addConstraintsWithFormat("V:|-5-[v0(27)]-5-|", views: CommentButton)
        
        LikeButton.addTarget(self, action: #selector(LikeButtonPressed), for: .touchUpInside)
        CommentButton.addTarget(self, action: #selector(CommentButtonPressed), for: .touchUpInside)
        CommentButton.setImage(UIImage(named: "OutlineComment.png"), for: UIControlState())
        
        if currentUserLikes()
                {
                    LikeButton.setImage(UIImage(named: "Liked.png"), for: UIControlState())
                }
                else
                {
                    LikeButton.setImage(UIImage(named: "UnLiked.png"), for: UIControlState())
                }
        
        if self.post.gathering != nil
        {
            let imageFile = self.post.gathering?.imageGathering
            
            gatheringimageView.file = imageFile
            gatheringimageView.load(inBackground: { (image, error) -> Void in
                //
            }, progressBlock: { (percent) -> Void in
                //
            })
            
            self.addSubview(gatheringimageView)
            
            addConstraintsWithFormat("H:[v0(30)]-10-|", views: gatheringimageView)
            addConstraintsWithFormat("V:|-3.5-[v0(30)]-3.5-|", views: gatheringimageView)
        }
        else
        {
            self.gatheringimageView.removeFromSuperview()
        }
        
    }
    
    @objc func GatheringImageClicked()
    {
        print(self.post.gathering?.nameGathering)
        if self.gatheringDelegate != nil
        {
            if self.post.gathering != nil
            {
                print("WTF is up")
                _ = post["gathering"] as! Gathering
                self.post.gathering?.fetchIfNeededInBackground(block: { (object, error) in
                    if error == nil{
                        print("Error is nil")
                        if object != nil
                        {
                            let someth = object as! Gathering
                            print(someth.nameGathering)
                            self.gatheringDelegate.GoToTheSelectedGathering(someth)
                        }
                    }
                })
            }
        }
        
        if self.xdelegate != nil
        {
            print("xdelegae is not nill")
        }
        //self.gatheringDelegate.GoToTheSelectedGathering(gathering: okay)
        
    }
    
    func currentUserLikes() -> Bool {
        if let ids = post.likerIds {
            if ids.contains((PFUser.current()!.objectId!)) {
                return true
            }
        }
        return false
    }
    
    @objc func LikeButtonPressed()
    {
        if currentUserLikes() {
            post.dislike()
            LikeButton.setImage(UIImage(named: "UnLiked.png"), for: UIControlState())
            if self.post.numberOfLikes == 1
            {
                //self.LikesButton.isHidden = false
                //self.LikesButton.setTitle("\(self.post.numberOfLikes) Like", for: UIControlState())
            }
            else if self.post.numberOfLikes > 1
            {
                //self.LikesButton.isHidden = false
                //self.LikesButton.setTitle("\(self.post.numberOfLikes) Likes", for: UIControlState())
            }
            else
            {
                //self.LikesButton.isHidden = true
            }
        } else {
            post.like()
            LikeButton.setImage(UIImage(named: "Liked.png"), for: UIControlState())
            if self.post.numberOfLikes == 1
            {
                //self.LikesButton.isHidden = false
                //self.LikesButton.setTitle("\(self.post.numberOfLikes) Like", for: UIControlState())
            }
            else if self.post.numberOfLikes > 1
            {
                //self.LikesButton.isHidden = false
                //self.LikesButton.setTitle("\(self.post.numberOfLikes) Likes", for: UIControlState())
            }
            else
            {
                //self.LikesButton.isHidden = true
            }
            let activity = Activity(UserWhoInitiatedActivity: PFUser.current() as! User!, UserOnWhomActivtyIsDone: post.UserWhoPosted, OnPost: self.post, numberIfALike: 1, numberIfAComment: 0)
            activity.saveInBackground(block: { (success, error) in
                if (success == true)
                {
                    print("activity logged successfully")
                }
                else
                {
                    print("activity logged unsuccessfully")
                }
            })
        }
    }
    
    @objc func CommentButtonPressed()
    {
        if self.delegate != nil
        {
            self.delegate.callSegueFromCell(self.post)
        }
    }
    
    func LikersButtonClicked()
    {
        print("LikeButton is clicked")
//        if self.likeDelegate != nil
//        {
//            self.likeDelegate.GoToLikers(self.post)
//        }
//        else
//        {
//            print("likeDelegate is nil")
//        }
        
    }
}
