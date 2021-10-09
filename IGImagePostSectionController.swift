//
//  IGImagePostSectionController.swift
//  Outline
//
//  Created by Apple on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

class PostSectionController: ListSectionController, NewMyCustomCellDelegator, ListWorkingRangeDelegate, UsernameButtonClickedDelegator, gatheringButtonClickedDelegator, someFuckAllDelegator
{
    func doSomething(_ post: Post) {
        print("fuckyourself")
    }
    
    var post: Post!
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
            return CGSize(width: width!, height: width!)
        } else if (index == 2) {
            
            let theusername = self.post.UserWhoPosted.username
            let theshares = post.shares
            let multipleAttributes: [String : Any] = [
                NSAttributedStringKey.foregroundColor.rawValue: UIColor.blue,
                NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-Medium", size:13)!]
            let attributedString = NSMutableAttributedString(string: theusername!, attributes: nil)
            
            attributedString.append(NSAttributedString(string: " \(theshares!)", attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size:13)!]))
            CaptionLabel.attributedText = attributedString
            CaptionLabel.sizeToFit()
            
            if let messageText = CaptionLabel.attributedText {
                let size = CGSize(width: ((collectionContext?.containerSize.width)! - 16), height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                //let estimatedFrame = NSAttributedString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
                let estimatedFrame = messageText.boundingRect(with: size, options: options, context: nil)
                
                return CGSize(width: (collectionContext?.containerSize.width)!, height: estimatedFrame.height + 10)
            }
        return CGSize(width: (collectionContext?.containerSize.width)!, height: 100)
        }else if (index == 3) {
            return CGSize(width: width!, height: 37)
        } else if (index == 4) {
            return CGSize(width: width!, height: 20)
        }
        
        return CGSize(width: (collectionContext?.containerSize.width)!, height: 40)
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
            let cell = collectionContext!.dequeueReusableCell(of: PostImageCell.self, for: self, at: index) as! PostImageCell
            cell.post = self.post
            //cell.setImage(image: downloadedImage)
            //cell.backgroundColor = UIColor.yellow
            return cell
        } else if (index == 2) {
            let cell = collectionContext!.dequeueReusableCell(of: CaptionCell.self, for: self, at: index) as! CaptionCell
            cell.post = self.post
            //cell.backgroundColor = UIColor.yellow
            return cell
        } else if (index == 3) {
            let cell = collectionContext!.dequeueReusableCell(of: LikeButtonCell.self, for: self, at: index) as! LikeButtonCell
            cell.gatheringDelegate = self
            cell.xdelegate = self
            cell.delegate = self
            
            cell.post = self.post
            
            //cell.backgroundColor = UIColor.yellow
            return cell
        } else if (index == 4) {
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
    
    func GoToIGFriendsVC(_ user: User)
    {
        let xIGFriendsVC = IGFriendsVC()
        xIGFriendsVC.user = user
        viewController?.navigationController?.pushViewController(xIGFriendsVC, animated: true)
    }
    
//    func GoToTheSelectedGathering(_ gathering: Gathering)
//    {
//        let someVC = GatheringVC()
//        someVC.gathering = gathering
//        viewController?.navigationController?.pushViewController(someVC, animated: true)
//    }
    
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
