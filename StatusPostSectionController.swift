//
//  StatusPostSectionController.swift
//  Outline
//
//  Created by Apple on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit

class StatusPostSectionController: ListSectionController, NewMyCustomCellDelegator, ListWorkingRangeDelegate, UsernameButtonClickedDelegator, StatusImageCellExpandedDelegator, gatheringButtonClickedDelegator
{
    var post: Post!
    var isStatusImageCellExpanded = false
    var cellClass: UICollectionViewCell!
    var CaptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        //label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    override func numberOfItems() -> Int
    {
        return 5
        
    }
    
    override init() {
        super.init()
        workingRangeDelegate = self
    }
    
    override func sizeForItem(at index: Int) -> CGSize
    {
        let width = collectionContext?.containerSize.width
        if (index == 0) {
            return CGSize(width: width!, height: 40)
        } else if (index == 1) {
            let theshares = post.shares
            let attributedString = NSAttributedString(string: theshares!, attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size:13)!])
            CaptionLabel.attributedText = attributedString
            CaptionLabel.sizeToFit()
            
            if let messageText = CaptionLabel.attributedText {
                let size = CGSize(width: ((collectionContext?.containerSize.width)! - 6), height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedFrame = messageText.boundingRect(with: size, options: options, context: nil)
                
                return CGSize(width: (collectionContext?.containerSize.width)!, height: estimatedFrame.height + 10)
            }
            
            return CGSize(width: (collectionContext?.containerSize.width)!, height: 100)
        }
        else if (index == 2) {
            if post.ImageFiles != nil
            {
                if self.isStatusImageCellExpanded == false
                {
                    return CGSize(width: width!, height: 200)
                }
                else
                {
                    return CGSize(width: width!, height: width!)
                }
            }
            else
            {
                return CGSize(width: 0, height: 0)
            }
        }
        else if (index == 3) {
            return CGSize(width: width!, height: 37)
        } else if (index == 4) {
            return CGSize(width: width!, height: 20)
        }
        return CGSize(width: (collectionContext?.containerSize.width)!, height: 100)
        
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell
    {
        if (index == 0) {
            let cell = collectionContext!.dequeueReusableCell(of: PostCell.self, for: self, at: index) as! PostCell
            cell.post = self.post
            cell.UsernameButtonClickedDelegate = self
            //cell.backgroundColor = UIColor.yellow
            return cell
        } else if (index == 1) {
            let cell = collectionContext!.dequeueReusableCell(of: OutlineStatusPostCell.self, for: self, at: index) as! OutlineStatusPostCell
            cell.post = self.post
            return cell
        }
        else if (index == 2) {
            if (post.ImageFiles) != nil
            {
                let cell = collectionContext!.dequeueReusableCell(of: StatusImageCell.self, for: self, at: index) as! StatusImageCell
                cell.delegate = self
                cell.post = self.post
                return cell
            }
            else
            {
                let cell = collectionContext!.dequeueReusableCell(of: UICollectionViewCell.self, for: self, at: index) 
                return cell
            }
        }
            else if (index == 3) {
            let cell = collectionContext!.dequeueReusableCell(of: LikeButtonCell.self, for: self, at: index) as! LikeButtonCell
            cell.gatheringDelegate = self
            cell.delegate = self
            cell.post = self.post
            return cell
        }
        else if (index == 4) {
            let cell = collectionContext!.dequeueReusableCell(of: DateCell.self, for: self, at: index) as! DateCell
            cell.post = self.post
            //cell.backgroundColor = UIColor.yellow
            return cell
        }
        return UICollectionViewCell()
    }
    
    func callSegueFromCell(_ post: Post)
    {
        let vc = IGCommentsVC()
        vc.post = post
        vc.userWhoPosted = post.UserWhoPosted
        vc.captionofPost = post.shares
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
     func ImageCellExpanded(_ isCellExpanded: Bool)
     {
        if isCellExpanded == true
        {
            self.isStatusImageCellExpanded = true
            //let somecell = self.cellForItem(at: 2) as! StatusImageCell
           // collectionContext?.reload(in: self, at: IndexSet(integer: 2))
            self.collectionContext?.invalidateLayout(for: self)
        }
        else
        {
            self.isStatusImageCellExpanded = false
            self.collectionContext?.invalidateLayout(for: self)
        }
    }
    
    func GoToIGFriendsVC(_ user: User)
    {
        let xIGFriendsVC = IGFriendsVC()
        xIGFriendsVC.user = user
        viewController?.navigationController?.pushViewController(xIGFriendsVC, animated: true)
    }
    
    func GoToTheSelectedGathering(_ gathering: Gathering) {
        let someVC = GatheringVC()
        someVC.gathering = gathering
        viewController?.navigationController?.pushViewController(someVC, animated: true)
    }
    
    override func didUpdate(to object: Any)
    {
        self.post = object as! Post
    }
    override func didSelectItem(at index: Int)
    {
        //print("\(post.name)")
    }
    
    //MARK: IGListWorkingRangeDelegate
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {}
}
