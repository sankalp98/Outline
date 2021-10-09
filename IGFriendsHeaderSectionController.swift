//
//  IGHeaderSectionController.swift
//  Outline
//
//  Created by Apple on 10/06/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

class IGFriendsHeaderSectionController: ListSectionController, IGGoToEditInfo, FollowButtonClicked, FollowingButtonClicked
{
    var user: User!
    var cellClass: UICollectionViewCell!
    var CaptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        //label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    override func numberOfItems() -> Int
    {
        return 3
        
    }
    override func sizeForItem(at index: Int) -> CGSize
    {
        let width = collectionContext?.containerSize.width
        if (index == 0)
        {
            return CGSize(width: width!, height: 200)
        }
        else if (index == 1)
        {
            var theshares = self.user.Status
            if theshares == nil || theshares == ""
            {
                theshares = ""
            }
            let attributedString = NSAttributedString(string: theshares!, attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size:13)!])
            CaptionLabel.attributedText = attributedString
            CaptionLabel.sizeToFit()
            
            if let messageText = CaptionLabel.attributedText {
                let size = CGSize(width: ((collectionContext?.containerSize.width)! - 6), height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedFrame = messageText.boundingRect(with: size, options: options, context: nil)
                
                return CGSize(width: (collectionContext?.containerSize.width)!, height: estimatedFrame.height + 10)
            }
            
            return CGSize(width: (collectionContext?.containerSize.width)!, height: 105)
            
        }
        else if (index == 2)
        {
            return CGSize(width: width!, height: 30)
        }
        return CGSize(width: width!, height: 200)
        
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell
    {
        if (index == 0)
        {
            let cell = collectionContext!.dequeueReusableCell(of: IGFriendsUpperHalfHeaderCell.self, for: self, at: index) as! IGFriendsUpperHalfHeaderCell
            cell.user = self.user
            cell.FollowButtonDelegate = self
            cell.FollowingButtonDelegate = self
            //cell.backgroundColor = UIColor.yellow
            return cell
        }
        else if (index == 1)
        {
            let cell = collectionContext!.dequeueReusableCell(of: StatusCell.self, for: self, at: index) as! StatusCell
            cell.user = self.user
            //cell.backgroundColor = UIColor.yellow
            return cell
        }
        else if (index == 2)
        {
            let cell = collectionContext!.dequeueReusableCell(of: LowerToolbarHeaderCell.self, for: self, at: index) as! LowerToolbarHeaderCell
            //cell.user = self.user
            //cell.backgroundColor = UIColor.yellow
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func IGGoToEditInfo()
    {
        print("Editinfopressed")
        let EditInfoVC: NewEditInfoVC = NewEditInfoVC()
        //self.navigationController.
        viewController?.navigationController?.pushViewController(EditInfoVC, animated: true)
    }
    
    override func didUpdate(to object: Any)
    {
        self.user = object as! User
    }
    override func didSelectItem(at index: Int)
    {
        print("\(index)")
    }
    
    func FollowButtonClicked()
    {
        let Follow: Follows = Follows(xFollower: User.current(), xFollowing: self.user)
        Follow.saveInBackground { (success, error) -> Void in
            if error == nil
            {
                print("Follow button clicked")
                if success == true
                {
                    
                    guard let cell = self.cellForItem(at: 0) as? IGFriendsUpperHalfHeaderCell else {
                        return
                    }
                    cell.FollowButton.isHidden = true
                    cell.FollowingButton.isHidden = false
                    let xx = self.user.objectId!
                    let yy = User.current()!.objectId!
                    PFCloud.callFunction(inBackground: "newincNumOfFollowers", withParameters: ["userId":xx,"currentId":yy], block: { (object, error) -> Void in
                        if error == nil
                        {
                            if success == true
                            {
                                print("Folowed perfectly")
                                self.user.fetchInBackground(block: { (object, error) -> Void in
                                    cell.numberOfFollowingsLabel.text = "\(self.user.xnumberOfFollowings)"
                                    cell.numberOfFollowingsLabel.text = "\(self.user.xnumberOfFollowers)"
                                })
                            }
                        }
                        else
                        {
                            print(error?.localizedDescription)
                        }
                    })
                    
                    var nOfFollowings = User.current()!.xnumberOfFollowings
                    nOfFollowings = nOfFollowings + 1
                    User.current()!.xnumberOfFollowings = nOfFollowings
                    User.current()!.saveInBackground(block: { (success, error) in
                        if error == nil
                        {
                            if success == true
                            {
                                cell.numberOfFollowingsLabel.text = "\(self.user.xnumberOfFollowings)"
                                cell.numberOfFollowersLabel.text = "\(self.user.xnumberOfFollowers)"
                            }
                        }
                        else
                        {
                            print("Error occured , could not increase Followings")
                        }
                    })
                    
                }
            }
        }
        
    }
    
    func FollowingButtonClicked()
    {
        let FollowQuery = PFQuery(className: "Follows")
        FollowQuery.whereKey("Follower", equalTo: User.current()!)
        FollowQuery.whereKey("Following", equalTo: self.user)
        FollowQuery.findObjectsInBackground { (objects, error) -> Void in
            if error == nil
            {
                guard let cell = self.cellForItem(at: 0) as? IGFriendsUpperHalfHeaderCell else {
                    return
                }
                cell.FollowingButton.isHidden = true
                cell.FollowButton.isHidden = false
                for object in objects!
                {
                    object.deleteInBackground(block: { (success, error) -> Void in
                        if error == nil
                        {
                            if success == true
                            {
                                print("\(String(describing: User.current()?.xnumberOfFollowers))")
                                print("\(String(describing: User.current()?.xnumberOfFollowings))")
                                print("\(self.user.xnumberOfFollowers)")
                                print("\(self.user.xnumberOfFollowings)")
                                cell.numberOfFollowingsLabel.text = "\(self.user.xnumberOfFollowings)"
                                cell.numberOfFollowersLabel.text = "\(self.user.xnumberOfFollowers)"
                            }
                        }
                    })
                    
                    PFCloud.callFunction(inBackground: "newdecNumOfFollowers", withParameters: ["userId": self.user.objectId! , "currentId" : User.current()!.objectId!], block: { (object, error) -> Void in
                        if error == nil
                        {
                            print("unFolowed perfectly")
                            self.user.fetchInBackground(block: { (object, error) -> Void in
                                cell.numberOfFollowingsLabel.text = "\(self.user.xnumberOfFollowings)"
                                cell.numberOfFollowersLabel.text = "\(self.user.xnumberOfFollowers)"
                            })
                        }
                        else
                        {
                            print("Failed")
                        }
                    })
                    var nOfFollowings = User.current()!.xnumberOfFollowings
                    nOfFollowings = nOfFollowings - 1
                    User.current()!.xnumberOfFollowings = nOfFollowings
                    User.current()!.saveInBackground(block: { (success, error) in
                        if error == nil
                        {
                            if success == true
                            {
                                cell.numberOfFollowingsLabel.text = "\(self.user.xnumberOfFollowings)"
                                cell.numberOfFollowersLabel.text = "\(self.user.xnumberOfFollowers)"
                            }
                        }
                        else
                        {
                            print("Error occured , could not decrease Followings")
                        }
                    })
                }
            }
        }
        
    }
}
