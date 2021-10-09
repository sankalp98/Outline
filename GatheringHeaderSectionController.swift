//
//  GatheringHeaderSectionController.swift
//  Outline
//
//  Created by Apple on 04/10/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit
import Parse
import ParseUI

class GatheringHeaderSectionController: ListSectionController
{
    var gathering: Gathering!
    var cellClass: UICollectionViewCell!
    //var post: Post!
    private var number: Int?
    
    override func numberOfItems() -> Int
    {
        return 1
        
    }
    override func sizeForItem(at index: Int) -> CGSize
    {
        let width = collectionContext?.containerSize.width
        if (index == 0)
        {
            return CGSize(width: width!, height: 130)
        }
        
        return CGSize(width: width!, height: 130)
        
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell
    {
        if (index == 0)
        {
            let cell = collectionContext!.dequeueReusableCell(of: GatheringHeaderViewCell.self, for: self, at: index) as! GatheringHeaderViewCell
            cell.gathering = self.gathering
            //cell.backgroundColor = UIColor.yellow
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    override func didUpdate(to object: Any)
    {
        number = object as? Int
    }
    override func didSelectItem(at index: Int)
    {
        print("\(index)")
    }
}

class GatheringHeaderViewCell: UICollectionViewCell
{
    var gathering: Gathering! {
        didSet {
            self.updateUI()
        }
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        //label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    var anotherView: GradientView = GradientView()
    
    var coverPicture: PFImageView = PFImageView()
    
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
        
        coverPicture.addSubview(xactivityView)
        xactivityView.startAnimating()
        
        self.addSubview(nameLabel)
        //UsernameLabel.text = "Sankalp Kasale"
        nameLabel.numberOfLines = 1
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 27)
        nameLabel.sizeToFit()
        self.addConstraintsWithFormat("H:|-5-[v0]-5-|", views: nameLabel)
        self.addConstraintsWithFormat("V:[v0]|", views: nameLabel)
        
        self.anotherView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraintsWithFormat("H:|[v0]|", views: anotherView)
        self.addConstraintsWithFormat("V:|[v0(130)]", views: anotherView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: coverPicture)
        self.addConstraintsWithFormat("V:|[v0(130)]", views: coverPicture)
    }
    
    func updateUI()
    {
        
        if let yolo = self.gathering.nameGathering
        {
            self.nameLabel.text = "\(String(describing: yolo))"
        }
        
        if self.gathering.imageGathering != nil
        {
            //self.nola = self.user!
            self.coverPicture.file = self.gathering.imageGathering
            self.coverPicture.load(inBackground: { (image, error) -> Void in
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
            self.coverPicture.image = UIImage(named: "lolwa.png")
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
