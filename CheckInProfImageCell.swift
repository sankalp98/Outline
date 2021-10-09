//
//  CheckInProfImageCell.swift
//  Outline
//
//  Created by Apple on 29/07/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

class CheckInProfImageCell: UICollectionViewCell
{
    var post: Post! {
        didSet {
            self.updateUI()
        }
    }
    
    //var postLabel = UILabel()
    var postimageView: PFImageView = {
        let imageView = PFImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var UsernameButton = UIButton()
    
    var UsernameButtonClickedDelegate: UsernameButtonClickedDelegator!
    
    var UserWhoPosted: User = User()
    
    let separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red: 200/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1).cgColor
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.addSublayer(separator)
        contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI()
    {
        //self.backgroundColor = UIColor.gray
        postimageView.translatesAutoresizingMaskIntoConstraints = false
        //postimageView.image = UIImage(named: "Dota")
        postimageView.backgroundColor = UIColor.lightGray
        
        self.addSubview(postimageView)
        
//        self.addSubview(UsernameButton)
//        UsernameButton.translatesAutoresizingMaskIntoConstraints = false
//        //let usernametext = self.UserWhoPosted.username
//        UsernameButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13)
//        self.UsernameButton.setTitle("Sankalp Kasle", for: UIControlState())
//        UsernameButton.setTitleColor(UIColor.blue, for: UIControlState())
//        //UsernameButton.addTarget(self, action: #selector(BigCell.UsernameButtonClicked), for: UIControlEvents.touchUpInside)
//        UsernameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        
        let height = self.contentView.frame.size.height
        print(height)
        
        //let width = self.contentView.frame.size.width - (height/2)
        
//        self.postimageView.center = self.contentView.center
//        self.postimageView.frame.size = CGSize(width: height, height: height)
        
        let widthConstraint = NSLayoutConstraint(item: postimageView, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
        
        let heightConstraint = NSLayoutConstraint(item: postimageView, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
        
        let xConstraint = NSLayoutConstraint(item: postimageView, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1, constant: 0)
        
        let yConstraint = NSLayoutConstraint(item: postimageView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, yConstraint])
        
        //addConstraintsWithFormat("H:|-\(width)-[v0(\(height))]-\(width)-|", views: postimageView)
        //addConstraintsWithFormat("V:|[v0]|", views: postimageView)
        self.postimageView.layer.cornerRadius = height/2
        
        
        self.UserWhoPosted = post.UserWhoPosted
        
        if self.UserWhoPosted.ProfilePicture != nil
        {
            postimageView.backgroundColor = UIColor.lightGray
            postimageView.file = self.UserWhoPosted.ProfilePicture
            postimageView.load(inBackground: { (image, error) -> Void in
                //self.ProfilePImageView.loadInBackground()
                //self.UsernameButton.setTitle(self.UserWhoPosted.username, for: UIControlState())
            }, progressBlock: { (percent) -> Void in
                //print(percent)
            })
        }
        else
        {
            postimageView.file = self.UserWhoPosted.ProfilePicture
            postimageView.contentMode = UIViewContentMode.scaleAspectFill
        }
    }
    
    func UsernameButtonClicked()
    {
        self.UsernameButtonClickedDelegate.GoToIGFriendsVC(post.UserWhoPosted)
    }
}
