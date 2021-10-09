//
//  IGActivityLikeCommentCell.swift
//  Outline
//
//  Created by Apple on 31/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit


class IGActivityLikeCommentCell: UICollectionViewCell {
    
    var activity: Activity! {
        didSet {
            self.setUpViews()
        }
    }
    
    let ProfileImageView: PFImageView = {
        let imageView = PFImageView()
        imageView.image = UIImage(named: "Dota.png")
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12.5
        return imageView
    }()
    
    let activitylabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        //label.backgroundColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ActivityImageView: PFImageView = {
        let imageView = PFImageView()
        //imageView.image = UIImage(named: "Dota.png")
        imageView.backgroundColor = UIColor.lightGray
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 0
        return imageView
    }()
    
    let DividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews()
    {
        self.backgroundColor = UIColor.white
        if let yolo1 = activity.UserWhoInitiatedActivity.username
        {
            if let yolo2 = activity.UserOnWhomActivtyIsDone.username
            {
                if self.activity.numberIfALike == 1
                {
                    activitylabel.text = "\(yolo1) liked \(yolo2)'s post"
                }
                else{
                    //fuck it
                }
                if self.activity.numberIfAComment == 1
                {
                    activitylabel.text = "\(yolo1) commented on \(yolo2)'s post"
                }
                else
                {
                    //fuck it
                }
            }
        }
        
        addSubview(DividerLineView)
        addConstraintsWithFormat("H:|-35-[v0]-2-|", views: DividerLineView)
        addConstraintsWithFormat("V:[v0(1)]|", views: DividerLineView)
        
        self.addSubview(ProfileImageView)
        addConstraintsWithFormat("H:|-5-[v0(25)]", views: ProfileImageView)
        addConstraintsWithFormat("V:[v0(25)]", views: ProfileImageView)
        addConstraint(NSLayoutConstraint(item: ProfileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addSubview(activitylabel)
        if self.activity.OnPost.ImageFiles != nil
        {
            self.addSubview(ActivityImageView)
            addConstraintsWithFormat("H:|-35-[v0]-2-[v1(25)]-5-|", views: activitylabel, ActivityImageView)
            addConstraintsWithFormat("V:|-5-[v0]-5-|", views: activitylabel)
            addConstraintsWithFormat("V:[v0(25)]", views: ActivityImageView)
            addConstraint(NSLayoutConstraint(item: ActivityImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            
            self.activity.OnPost.fetchIfNeededInBackground { (post, error) in
                if let xpost = post as? Post
                {
                    if xpost.ImageFiles != nil
                    {
                        self.ActivityImageView.backgroundColor = UIColor.lightGray
                        self.ActivityImageView.file = xpost.ImageFiles
                        self.ActivityImageView.load(inBackground: nil, progressBlock: { (number) -> Void in
                            print(number)
                        })
                    }
                }
            }
        }
        else
        {
            addConstraintsWithFormat("V:|-5-[v0]-5-|", views: activitylabel)
            addConstraintsWithFormat("H:|-35-[v0]-5-|", views: activitylabel)
        }
        
        if self.activity.UserWhoInitiatedActivity.ProfilePicture != nil
        {
            ProfileImageView.backgroundColor = UIColor.lightGray
            ProfileImageView.file = self.activity.UserWhoInitiatedActivity.ProfilePicture
            self.ProfileImageView.load(inBackground: nil, progressBlock: { (number) -> Void in
                print(number)
            })
        }
        else
        {
            ProfileImageView.backgroundColor = UIColor.lightGray
        }
        
    }
    
}
