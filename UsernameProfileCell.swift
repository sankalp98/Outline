//
//  1.swift
//  Outline
//
//  Created by Apple on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

protocol UsernameButtonClickedDelegator
{
    func GoToIGFriendsVC(_ user: User)
}

class PostCell: UICollectionViewCell
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
        imageView.layer.cornerRadius = 15
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
        //contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI()
    {
        postimageView.translatesAutoresizingMaskIntoConstraints = false
        //postimageView.image = UIImage(named: "my")
        self.addSubview(postimageView)
        
        self.addSubview(UsernameButton)
        UsernameButton.translatesAutoresizingMaskIntoConstraints = false
        //let usernametext = self.UserWhoPosted.username
        UsernameButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13)
        //let gg = "\(String(describing: self.user.username!))"
        self.UsernameButton.setTitle("...", for: UIControlState())
        //UsernameButton.setTitleColor(UIColor.blue, for: UIControlState())
        UsernameButton.setTitleColor(UIColor.black, for: UIControlState())
        UsernameButton.addTarget(self, action: #selector(UsernameButtonClicked), for: UIControlEvents.touchUpInside)
        UsernameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        
        addConstraintsWithFormat("H:|-5-[v0(30)]-5-[v1]-5-|", views: postimageView, UsernameButton)
        addConstraintsWithFormat("V:|-5-[v0(30)]-5-|", views: postimageView)
        addConstraintsWithFormat("V:|-5-[v0(30)]", views: UsernameButton)
        
        self.UserWhoPosted = post.UserWhoPosted
        
        let gg = "\(String(describing: self.UserWhoPosted.username!))"
        self.UsernameButton.setTitle("\(String(describing: gg))", for: UIControlState())
        
        if self.UserWhoPosted.ProfilePicture != nil
        {
            postimageView.backgroundColor = UIColor.lightGray
            postimageView.file = self.UserWhoPosted.ProfilePicture
            postimageView.load(inBackground: { (image, error) -> Void in
                //self.ProfilePImageView.loadInBackground()
                self.UsernameButton.setTitle(self.UserWhoPosted.username, for: UIControlState())
            }, progressBlock: { (percent) -> Void in
                //print(percent)
            })
        }
        else
        {
            postimageView.backgroundColor = UIColor.lightGray
            //postimageView.file = self.UserWhoPosted.ProfilePicture
            //postimageView.contentMode = UIViewContentMode.scaleAspectFill
        }
    }
    
    @objc func UsernameButtonClicked()
    {
        self.UsernameButtonClickedDelegate.GoToIGFriendsVC(post.UserWhoPosted)
    }
}
