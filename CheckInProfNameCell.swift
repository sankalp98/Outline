//
//  CheckInProfNameCell.swift
//  Outline
//
//  Created by Apple on 29/07/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

class CheckInProfNameCell: UICollectionViewCell
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
        contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI()
    {
        self.addSubview(UsernameButton)
        UsernameButton.translatesAutoresizingMaskIntoConstraints = false
        //let usernametext = self.UserWhoPosted.username
        UsernameButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 10)
        self.UsernameButton.setTitle("Sankalp Kasle", for: UIControlState())
        //UsernameButton.setTitleColor(UIColor.blue, for: UIControlState())
        UsernameButton.setTitleColor(UIColor.black, for: UIControlState())
        UsernameButton.addTarget(self, action: #selector(UsernameButtonClicked), for: UIControlEvents.touchUpInside)
        UsernameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        
        addConstraintsWithFormat("H:|[v0]|", views: UsernameButton)
        addConstraintsWithFormat("V:|[v0]|", views: UsernameButton)
        
        self.UserWhoPosted = post.UserWhoPosted
        
        self.UsernameButton.setTitle(self.UserWhoPosted.username, for: UIControlState())
    }
    
    @objc func UsernameButtonClicked()
    {
        self.UsernameButtonClickedDelegate.GoToIGFriendsVC(post.UserWhoPosted)
    }
}
