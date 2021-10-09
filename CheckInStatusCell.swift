//
//  CheckInStatusCell.swift
//  Outline
//
//  Created by Apple on 30/07/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit
import Parse

class CheckInStatusCell: UICollectionViewCell
{
    var post: Post! {
        didSet {
            self.updateUI()
        }
    }
    
    var CaptionLabel: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        //label.backgroundColor = UIColor.yellow
        return label
    }()
    
    func updateUI()
    {
        print("OLOLOLO")
        //let theusername = self.post.UserWhoPosted.username
        let someText = post.shares
        let attributedString = NSAttributedString(string: "\(someText!)", attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size:11)!])
        CaptionLabel.textAlignment = .center
        CaptionLabel.attributedText = attributedString
        
        CaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(CaptionLabel)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: CaptionLabel)
        addConstraintsWithFormat("V:|-2-[v0]-2-|", views: CaptionLabel)
        
    }
}
