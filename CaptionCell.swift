//
//  3.swift
//  Outline
//
//  Created by Apple on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit
import Parse

class CaptionCell: UICollectionViewCell
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
        //label.backgroundColor = UIColor.yellow
        return label
    }()
    
    func updateUI()
    {
        let theusername = self.post.UserWhoPosted.username
        let theshares = post.shares
        let multipleAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium", size:13)!]
        let attributedString = NSMutableAttributedString(string: theusername!, attributes: multipleAttributes)
        
        attributedString.append(NSAttributedString(string: " \(theshares!)", attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size:13)!]))
        CaptionLabel.attributedText = attributedString
        CaptionLabel.sizeToFit()
        
        CaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(CaptionLabel)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: CaptionLabel)
        addConstraintsWithFormat("V:|-5-[v0]-2-|", views: CaptionLabel)
        
    }
}
