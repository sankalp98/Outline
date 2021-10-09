//
//  IGHeaderViewSectionController.swift
//  Outline
//
//  Created by Apple on 31/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit

class HeaderSectionController: ListSectionController, IGGoToEditInfo
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
            let cell = collectionContext!.dequeueReusableCell(of: UpperHalfHeaderCell.self, for: self, at: index) as! UpperHalfHeaderCell
            cell.user = self.user
            cell.IGGoToEditInfoDelegate = self
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
}
