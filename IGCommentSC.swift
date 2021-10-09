//
//  IGCommentSC.swift
//  Outline
//
//  Created by Apple on 27/01/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

class IGCommentSectionController: ListSectionController, ListWorkingRangeDelegate, UsernameButtonClickedDelegator
{
    var post: Post!
    var comment: IGComment!
    private var downloadedImage: UIImage?
    var cellClass: UICollectionViewCell!
    var CaptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        //label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    override func numberOfItems() -> Int
    {
        return 1
        
    }
    
    override init() {
        super.init()
        workingRangeDelegate = self
    }
    
    override func sizeForItem(at index: Int) -> CGSize
    {
        let width = collectionContext?.containerSize.width
        if (index == 0) {
            let frame = CGRect(x: 0, y: 0, width: width!, height: 50)
            let dummyCell = IGCommentCell(frame: frame)
            dummyCell.comment = self.comment
            dummyCell.layoutIfNeeded()
            
            let targetSize = CGSize(width: width!, height: 1000)
            let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
            
            let height = max(40 + 8 + 8, estimatedSize.height)
            return CGSize(width: width!, height: height)
        }
        return CGSize(width: (collectionContext?.containerSize.width)!, height: 40)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell
    {
        if (index == 0) {
            let cell = collectionContext!.dequeueReusableCell(of: IGCommentCell.self, for: self, at: index) as! IGCommentCell
            cell.comment = self.comment
            //cell.UsernameButtonClickedDelegate = self
            //cell.backgroundColor = UIColor.yellow
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func GoToIGFriendsVC(_ user: User)
    {
        let xIGFriendsVC = IGFriendsVC()
        xIGFriendsVC.user = user
        viewController?.navigationController?.pushViewController(xIGFriendsVC, animated: true)
    }
    
    override func didUpdate(to object: Any)
    {
        self.comment = object as! IGComment
    }
    override func didSelectItem(at index: Int)
    {
        print("\(index)")
    }
    
    //MARK: IGListWorkingRangeDelegate
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {}
}
