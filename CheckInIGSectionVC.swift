//
//  CheckInIGSectionVC.swift
//  Outline
//
//  Created by Apple on 29/07/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit

class CheckInIGSectionVC: ListSectionController, NewMyCustomCellDelegator, ListWorkingRangeDelegate, UsernameButtonClickedDelegator, StatusImageCellExpandedDelegator
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
            return CGSize(width: width!, height: 80)
        } else if (index == 1) {
            return CGSize(width: (collectionContext?.containerSize.width)!, height: 15)
        }
        else if (index == 2) {
            let theshares = post.shares
            let attributedString = NSAttributedString(string: theshares!, attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size:11)!])
            CaptionLabel.textAlignment = .center
            CaptionLabel.attributedText = attributedString
            CaptionLabel.sizeToFit()
            
            if let messageText = CaptionLabel.attributedText {
                let size = CGSize(width: ((collectionContext?.containerSize.width)! - 6), height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedFrame = messageText.boundingRect(with: size, options: options, context: nil)
                
                return CGSize(width: (collectionContext?.containerSize.width)!, height: estimatedFrame.height + 7)
            }
            
            
        }
        else if (index == 3) {
            if (post.isMapShown == 1)
            {
                return CGSize(width: width!, height: 150)
            }
            else
            {
                return CGSize(width: width!, height: 0)
            }
        } else if (index == 4) {
            return CGSize(width: width!, height: 20)
        }
        return CGSize(width: (collectionContext?.containerSize.width)!, height: 100)
        
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell
    {
        if (index == 0) {
            let cell = collectionContext!.dequeueReusableCell(of: CheckInProfImageCell.self, for: self, at: index) as! CheckInProfImageCell
            cell.post = self.post
            cell.UsernameButtonClickedDelegate = self
            //cell.backgroundColor = UIColor.yellow
            return cell
        } else if (index == 1) {
            let cell = collectionContext!.dequeueReusableCell(of: CheckInProfNameCell.self, for: self, at: index) as! CheckInProfNameCell
            cell.post = self.post
            cell.UsernameButtonClickedDelegate = self
            return cell
        }
        else if (index == 2) {
        let cell = collectionContext!.dequeueReusableCell(of: CheckInStatusCell.self, for: self, at: index) as! CheckInStatusCell
                //cell.delegate = self
                cell.post = self.post
                return cell
        }
        else if (index == 3) {
            let cell = collectionContext!.dequeueReusableCell(of: CheckInMapsCell.self, for: self, at: index) as! CheckInMapsCell
            //cell.delegate = self
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
