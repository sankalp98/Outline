//
//  SearchedUserSC.swift
//  Outline
//
//  Created by Apple on 28/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

protocol UserCellClicked1Delegator
{
    func GoToSearchedIGFriendsVC1(_ user: User)
}

class SearchedUserSC: ListSectionController, UserCellClickedDelegator
{
    var user: User!
    
    var delegate: UserCellClicked1Delegator!
    
    override func numberOfItems() -> Int
    {
        return 1
        
    }
    
    override func sizeForItem(at index: Int) -> CGSize
    {
        let width = collectionContext?.containerSize.width
        if (index == 0) {
            return CGSize(width: width!, height: 40)
        }
        
        return CGSize(width: (collectionContext?.containerSize.width)!, height: 40)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell
    {
        if (index == 0) {
            let cell = collectionContext!.dequeueReusableCell(of: SearchedUserCell.self, for: self, at: index) as! SearchedUserCell
            cell.user = self.user
            cell.UserCellClickedDelegate = self
            //cell.backgroundColor = UIColor.yellow
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func GoToSearchedIGFriendsVC(_ xuser: User) {
        
//        let xIGFriendsVC = IGFriendsVC()
//        xIGFriendsVC.user = user
//        viewController?.navigationController?.pushViewController(xIGFriendsVC, animated: true)
        
        if xuser == nil
        {
            print("NULL")
        }
        else
        {
            if delegate != nil
            {
                print(xuser.objectId)
                self.delegate.GoToSearchedIGFriendsVC1(xuser)
            }
            else
            {
                print("Delegate is null")
            }
        }
    }
    
    func nameClicked()
    {
//        let xIGFriendsVC = IGFriendsVC()
//        xIGFriendsVC.user = user
//        viewController?.navigationController?.pushViewController(xIGFriendsVC, animated: true)
        
        //print(self.user.username)
        //self.delegate.GoToSearchedIGFriendsVC1(user)
    }
    
    override func didUpdate(to object: Any)
    {
        self.user = object as! User
    }
    override func didSelectItem(at index: Int)
    {
        print("\(index)")
    }
}

protocol UserCellClickedDelegator
{
    func GoToSearchedIGFriendsVC(_ xuser: User)
}

class SearchedUserCell: UICollectionViewCell
{
    var UserCellClickedDelegate: UserCellClickedDelegator!
    
    var user: User! {
        didSet {
            self.updateUI()
        }
    }
    
    var postimageView: PFImageView = {
        let imageView = PFImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var UsernameButton = UIButton()
    
    //var UsernameButtonClickedDelegate: UsernameButtonClickedDelegator!
    
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
        let gg = "\(String(describing: self.user.username!))"
        self.UsernameButton.setTitle("\(String(describing: gg))", for: UIControlState())
        //UsernameButton.setTitleColor(UIColor.blue, for: UIControlState())
        UsernameButton.setTitleColor(UIColor.black, for: UIControlState())
        UsernameButton.addTarget(self, action: #selector(UsernameButtonClicked), for: UIControlEvents.touchUpInside)
        UsernameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        
        addConstraintsWithFormat("H:|-5-[v0(30)]-5-[v1]-5-|", views: postimageView, UsernameButton)
        addConstraintsWithFormat("V:|-5-[v0(30)]-5-|", views: postimageView)
        addConstraintsWithFormat("V:|-5-[v0(30)]", views: UsernameButton)
        
        if self.user.ProfilePicture != nil
        {
            postimageView.backgroundColor = UIColor.lightGray
            postimageView.file = self.user.ProfilePicture
            postimageView.load(inBackground: { (image, error) -> Void in
                //self.ProfilePImageView.loadInBackground()
                self.UsernameButton.setTitle(self.user.username, for: UIControlState())
                
            }, progressBlock: { (percent) -> Void in
                print(percent)
            })
        }
        else
        {
            postimageView.backgroundColor = UIColor.lightGray
            postimageView.contentMode = UIViewContentMode.scaleAspectFill
        }
    }
    
    @objc func UsernameButtonClicked()
    {
        print(self.user.objectId)
        self.UserCellClickedDelegate.GoToSearchedIGFriendsVC(self.user)
    }
}
