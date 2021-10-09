//
//  ActivityLikeAndComment.swift
//  Outline
//
//  Created by Apple on 31/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

class ActivityLikeAndCommentSectionController: ListSectionController, ListWorkingRangeDelegate
{
    var activity: Activity!
    private var downloadedImage: UIImage?
    var cellClass: UICollectionViewCell!
    var CaptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        //label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    
    var activityStatuses = ["Sankalp kasle likes sankalp kasle's photo. Sankalp kasle likes sankalp kasle's photo. Sankalp kasle likes sankalp kasle's photo. Sankalp kasle likes sankalp kasle's photo.", "Sankalp kasle likes sankalp kasle's photo. Sankalp kasle likes sankalp kasle's photo. Sankalp kasle likes sankalp kasle's photo. Sankalp kasle likes sankalp kasle's photo.", "Sankalp kasle likes sankalp kasle's photo. Sankalp kasle likes sankalp kasle's photo. Sankalp kasle likes sankalp kasle's photo. Sankalp kasle likes sankalp kasle's photo."]
    
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
            var someSize: CGSize = CGSize()
            let ggsomething = self.activity
            ggsomething?.UserWhoInitiatedActivity.fetchIfNeededInBackground { (object1, error) in
                let object1 = object1 as! User
                if error == nil
                {
                    ggsomething?.UserOnWhomActivtyIsDone.fetchIfNeededInBackground(block: { (object2, error) in
                        let object2 = object2 as! User
                        if error == nil
                        {
                            if ggsomething?.numberIfALike == 1
                            {
                                //                                let multipleAttributes: [String : Any] = [
                                //                                    NSForegroundColorAttributeName: UIColor.black,
                                //                                    NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size:13)!]
                                //                                let attributedString = NSMutableAttributedString(string: "\(object1.username)", attributes: multipleAttributes)
                                //
                                //                                attributedString.append(NSAttributedString(string: " liked ", attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue", size:13)!]))
                                //
                                //                                attributedString.append(NSMutableAttributedString(string: "\(object2.username)", attributes: multipleAttributes))
                                //
                                //                                let thetext = attributedString
                                let thetext = "\(String(describing: object1.username)) liked \(String(describing: object2.username))'s photo"
                                self.activityStatuses.insert(thetext, at: index)
                                let messageText = self.activityStatuses[index]
                                let size = CGSize(width: (self.collectionContext?.containerSize.width)! - 67, height: 1000)
                                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                                let estimatedFrame = NSString(string: thetext).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)], context: nil)
                                someSize = CGSize(width:(self.collectionContext?.containerSize.width)!,height: estimatedFrame.height + 20)
                                //return CGSize(width: self.view.frame.width,height: estimatedFrame.height + 20)
                            }
                            if ggsomething?.numberIfAComment == 1
                            {
                                let thetext = "\(String(describing: object1.username)) commented on \(String(describing: object2.username))'s photo"
                                self.activityStatuses.insert(thetext, at: index)
                                let messageText = self.activityStatuses[index]
                                let size = CGSize(width: (self.collectionContext?.containerSize.width)! - 67, height: 1000)
                                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                                let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)], context: nil)
                                someSize = CGSize(width: (self.collectionContext?.containerSize.width)!,height: estimatedFrame.height + 20)
                                //return CGSize(width: self.view.frame.width,height: estimatedFrame.height + 20)
                            }
                        }
                    })
                }
            }
            return someSize
        }
        
        return CGSize(width: (collectionContext?.containerSize.width)!, height: 40)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell
    {
        if (index == 0) {
            let cell = collectionContext!.dequeueReusableCell(of: IGActivityLikeCommentCell.self, for: self, at: index) as! IGActivityLikeCommentCell
            cell.activity = self.activity
            //cell.backgroundColor = UIColor.yellow
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    override func didUpdate(to object: Any)
    {
        self.activity = object as! Activity
    }
    override func didSelectItem(at index: Int)
    {
        print("\(index)")
    }
    
    //MARK: IGListWorkingRangeDelegate
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        
        //        if post.ImageFiles != nil
        //        {
        //            print("Image file is not nill")
        //            if let cell = self.collectionContext?.cellForItem(at: 1, sectionController: self) as? PostImageCell
        //            {
        //                let imageFile = self.post.ImageFiles
        //                imageFile!.getDataInBackground({ (imagedata, error) in
        //                    if error == nil
        //                    {
        //                        if let imageData = imagedata {
        //                            let image = UIImage(data:imageData)
        //                            self.downloadedImage = image
        //                            cell.setImage(image: image)
        //                        }
        //                    }
        //                    else
        //                    {
        //                        print("\(String(describing: error?.localizedDescription))")
        //                    }
        //                }, progressBlock: { (loader) in
        //                    //
        //                })
        //            }
        //            else
        //            {
        //                print("problem yaha hai")
        //            }
        //        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {}
}
