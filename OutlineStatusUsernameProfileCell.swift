//
//  1.swift
//  Outline
//
//  Created by Apple on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit

class StatusUsernameProfileCell: UICollectionViewCell
{
    var post: Post! {
        didSet {
            self.updateUI()
        }
    }
    
    //var postLabel = UILabel()
    var postimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var UsernameButton = UIButton()
    
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
        //self.backgroundColor = UIColor.gray
        postimageView.translatesAutoresizingMaskIntoConstraints = false
        postimageView.image = UIImage(named: "my")
        self.addSubview(postimageView)
        
        self.addSubview(UsernameButton)
        UsernameButton.translatesAutoresizingMaskIntoConstraints = false
        //let usernametext = self.UserWhoPosted.username
        UsernameButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13)
        self.UsernameButton.setTitle("Sankalp Kasle", for: UIControlState())
        //UsernameButton.setTitleColor(UIColor.blue, for: UIControlState())
        UsernameButton.setTitleColor(UIColor.black, for: UIControlState())
        //UsernameButton.addTarget(self, action: #selector(BigCell.UsernameButtonClicked), for: UIControlEvents.touchUpInside)
        UsernameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        
        addConstraintsWithFormat("H:|-5-[v0(30)]-5-[v1]-5-|", views: postimageView, UsernameButton)
        addConstraintsWithFormat("V:|-5-[v0(30)]-5-|", views: postimageView)
        addConstraintsWithFormat("V:|-5-[v0(30)]", views: UsernameButton)
        
        //        postLabel.translatesAutoresizingMaskIntoConstraints = false
        //        postLabel.backgroundColor = UIColor.yellow
        //        self.addSubview(postLabel)
        //        addConstraintsWithFormat("H:|[v0]|", views: postLabel)
        //        addConstraintsWithFormat("V:|[v0]|", views: postLabel)
        //        postLabel.text = post.name
    }
}
