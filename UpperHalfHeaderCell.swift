//
//  UpperHalfHeaderCell.swift
//  Outline
//
//  Created by Apple on 31/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

protocol IGGoToEditInfo {
    func IGGoToEditInfo()
}

class UpperHalfHeaderCell: UICollectionViewCell
{
    var user: User! {
        didSet {
            self.updateUI()
        }
    }
    
    var numberOfPosts = 0
    
    var IGGoToEditInfoDelegate:IGGoToEditInfo!
    var coverPicture: PFImageView = PFImageView()
    var segmentedC: UISegmentedControl = UISegmentedControl(items: ["Posts", "Status"])
    var ProfilePicture: PFImageView = PFImageView()
    var UsernameLabel: UILabel = UILabel()
    var titleForPostsLabel: UILabel = UILabel()
    var titleForFollowingsLabel: UILabel = UILabel()
    var titleForFollowersLabel: UILabel = UILabel()
    var numberOfPostsLabel: UILabel = UILabel()
    var numberOfFollowersLabel: UILabel = UILabel()
    var numberOfFollowingsLabel: UILabel = UILabel()
    var stackView1: UIStackView = UIStackView()
    var stackView2: UIStackView = UIStackView()
    var stackView3: UIStackView = UIStackView()
    var StackViewAll: UIStackView = UIStackView()
    var EditInfoButton: UIButton = UIButton()
    var StatusLabel: UILabel = UILabel()
    var heightConstraint: NSLayoutConstraint!
    var anotherView: GradientView = GradientView()
    //var GoToEditInfoDelegate: GoToEditInfo!
    var nola: User!
    
    fileprivate let activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.startAnimating()
        return view
    }()
    
    fileprivate let xactivityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.startAnimating()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(coverPicture)
        coverPicture.translatesAutoresizingMaskIntoConstraints = true
        //coverPicture.image = UIImage(named: "itachieyes.png")
        coverPicture.backgroundColor = UIColor.lightGray
        coverPicture.contentMode = .scaleAspectFill
        coverPicture.clipsToBounds = true
        self.addSubview(anotherView)
        
        self.addSubview(ProfilePicture)
        ProfilePicture.translatesAutoresizingMaskIntoConstraints = false
        ProfilePicture.backgroundColor = UIColor.lightGray
        ProfilePicture.contentMode = .scaleAspectFill
        ProfilePicture.layer.cornerRadius = 50
        ProfilePicture.layer.borderWidth = 1
        ProfilePicture.layer.borderColor = UIColor.gray.cgColor
        ProfilePicture.clipsToBounds = true
        ProfilePicture.addConstraint(NSLayoutConstraint(item: ProfilePicture, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        ProfilePicture.addConstraint(NSLayoutConstraint(item: ProfilePicture, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        
        ProfilePicture.addSubview(activityView)
        coverPicture.addSubview(xactivityView)
        activityView.startAnimating()
        xactivityView.startAnimating()
        
        self.addSubview(UsernameLabel)
        //UsernameLabel.text = "Sankalp Kasale"
        UsernameLabel.numberOfLines = 1
        UsernameLabel.textColor = UIColor.white
        UsernameLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 27)
        UsernameLabel.sizeToFit()
        self.addConstraintsWithFormat("H:|[v0(100)]-2-[v1]|", views: ProfilePicture, UsernameLabel)
        
        self.anotherView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraintsWithFormat("H:|[v0]|", views: anotherView)
        self.addConstraintsWithFormat("V:|[v0(130)]", views: anotherView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: coverPicture)
        self.addConstraintsWithFormat("V:|[v0(130)]", views: coverPicture)
        
        self.addConstraint(NSLayoutConstraint(item: ProfilePicture, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: coverPicture, attribute: .bottom, multiplier: 1, constant: 50))
        self.addConstraint(NSLayoutConstraint(item: UsernameLabel, attribute: .bottom, relatedBy: .equal, toItem: ProfilePicture, attribute: .bottom, multiplier: 1, constant: -50))
        
        self.ArrangeThings()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ArrangeThings()
    {
        self.titleForPostsLabel.text = "posts"
        self.titleForPostsLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        self.titleForPostsLabel.textColor = UIColor.gray
        self.titleForPostsLabel.sizeToFit()
        
        self.titleForFollowingsLabel.text = "followings"
        self.titleForFollowingsLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        self.titleForFollowingsLabel.textColor = UIColor.gray
        self.titleForFollowingsLabel.sizeToFit()
        
        self.titleForFollowersLabel.text = "followers"
        self.titleForFollowersLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        self.titleForFollowersLabel.textColor = UIColor.gray
        self.titleForFollowersLabel.sizeToFit()
        
        self.numberOfPostsLabel.text = "10"
        self.numberOfPostsLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        self.numberOfPostsLabel.textAlignment = NSTextAlignment.center
        self.numberOfPostsLabel.sizeToFit()
        
        self.numberOfFollowersLabel.text = "11"
        self.numberOfFollowersLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        self.numberOfFollowersLabel.textAlignment = NSTextAlignment.center
        self.numberOfFollowersLabel.sizeToFit()
        
        self.numberOfFollowingsLabel.text = "12"
        self.numberOfFollowingsLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        self.numberOfFollowingsLabel.textAlignment = NSTextAlignment.center
        self.numberOfFollowingsLabel.sizeToFit()
        
        self.allStackViewInOneStackView()
    }
    
    func AddThingsInsideStackView1()
    {
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView1.axis  = UILayoutConstraintAxis.vertical
        stackView1.distribution  = UIStackViewDistribution.equalCentering
        stackView1.alignment = UIStackViewAlignment.center
        
        stackView1.addArrangedSubview(numberOfPostsLabel)
        stackView1.addArrangedSubview(titleForPostsLabel)
    }
    
    func AddThingsInsideStackView2()
    {
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.axis  = UILayoutConstraintAxis.vertical
        stackView2.distribution  = UIStackViewDistribution.equalCentering
        stackView2.alignment = UIStackViewAlignment.center
        
        stackView2.addArrangedSubview(numberOfFollowersLabel)
        stackView2.addArrangedSubview(titleForFollowersLabel)
    }
    
    func AddThingsInsideStackView3()
    {
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        stackView3.axis  = UILayoutConstraintAxis.vertical
        stackView3.distribution  = UIStackViewDistribution.equalCentering
        stackView3.alignment = UIStackViewAlignment.center
        
        stackView3.addArrangedSubview(numberOfFollowingsLabel)
        stackView3.addArrangedSubview(titleForFollowingsLabel)
    }
    
    func allStackViewInOneStackView()
    {
        self.AddThingsInsideStackView1()
        self.AddThingsInsideStackView2()
        self.AddThingsInsideStackView3()
        
        StackViewAll.translatesAutoresizingMaskIntoConstraints = false
        StackViewAll.axis  = UILayoutConstraintAxis.horizontal
        StackViewAll.distribution  = UIStackViewDistribution.equalCentering
        StackViewAll.alignment = UIStackViewAlignment.center
        //stackView.spacing   = 16.0
        
        StackViewAll.addArrangedSubview(stackView1)
        StackViewAll.addArrangedSubview(stackView2)
        StackViewAll.addArrangedSubview(stackView3)
        
        self.addSubview(StackViewAll)
        
        self.addConstraint(NSLayoutConstraint(item: StackViewAll, attribute: .top, relatedBy: .equal, toItem: UsernameLabel, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: StackViewAll, attribute: .left, relatedBy: .equal, toItem: ProfilePicture, attribute: .right, multiplier: 1, constant: 3))
        self.addConstraintsWithFormat("H:[v0]-3-|", views: StackViewAll)
        self.addConstraint(NSLayoutConstraint(item: StackViewAll, attribute: .bottom, relatedBy: .equal, toItem: ProfilePicture, attribute: .bottom, multiplier: 1, constant: 0))
        
        self.addEditInfoButton()
    }
    
    func addEditInfoButton()
    {
        self.addSubview(self.EditInfoButton)
        EditInfoButton.translatesAutoresizingMaskIntoConstraints = false
        EditInfoButton.setTitle("Edit Info", for: UIControlState())
        EditInfoButton.backgroundColor = UIColor.lightGray
        EditInfoButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13)
        EditInfoButton.layer.cornerRadius = 2
        EditInfoButton.addTarget(self, action: #selector(self.vEditInfoButtonClicked), for: UIControlEvents.touchUpInside)
        EditInfoButton.isUserInteractionEnabled = true
        EditInfoButton.setTitleColor(UIColor.white, for: UIControlState())
        
        self.addConstraint(NSLayoutConstraint(item: EditInfoButton, attribute: .top, relatedBy: .equal, toItem: StackViewAll, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: EditInfoButton, attribute: .left, relatedBy: .equal, toItem: StackViewAll, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: EditInfoButton, attribute: .right, relatedBy: .equal, toItem: StackViewAll, attribute: .right, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: EditInfoButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
    }
    
    @objc func vEditInfoButtonClicked()
    {
        self.IGGoToEditInfoDelegate.IGGoToEditInfo()
    }
    
    func updateUI()
    {
        
        if self.user.username != nil
        {
            let yolo = self.user.username!
            self.UsernameLabel.text = "\(yolo)"
        }
        
        if self.user.CoverPicture != nil
        {
            self.nola = self.user!
            self.coverPicture.file = self.nola.CoverPicture
            self.coverPicture.load(inBackground: { (image, error) -> Void in
                if error == nil
                {
                    self.activityView.stopAnimating()
                    //...
                }
            }, progressBlock: { (percent) -> Void in
                //..
            })
        }
        else
        {
            //self.coverPicture.image = UIImage(named: "lolwa.png")
            self.coverPicture.backgroundColor = UIColor.lightGray
            
        }
        
        if self.user.ProfilePicture != nil
        {
            //self.ProfilePictureView.file = self.user.ProfilePicture
            self.nola = self.user!
            self.ProfilePicture.file = self.nola.ProfilePicture
            self.ProfilePicture.load(inBackground: { (image, error) -> Void in
                if error == nil
                {
                    self.xactivityView.stopAnimating()
                    //...
                }
            }, progressBlock: { (percent) -> Void in
                //..
            })
        }
        else
        {
            //self.ProfilePicture.image = UIImage(named: "lolwa.png")
            self.ProfilePicture.backgroundColor = UIColor.lightGray
        }
        
        let suno = self.user!
        self.numberOfFollowersLabel.text = "\(suno.xnumberOfFollowers)"
        self.numberOfFollowingsLabel.text = "\(suno.xnumberOfFollowings)"
        if (self.user.xnumberOfPosts) != 0
        {
            let numberOfPosts = self.user.xnumberOfPosts
            self.numberOfPostsLabel.text = "\(numberOfPosts)"
        }
        else
        {
            self.numberOfPostsLabel.text = "0"
        }
        
        
    }
}
