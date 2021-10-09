//
//  IGCommentCell.swift
//  Outline
//
//  Created by Apple on 27/01/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class IGCommentCell: UICollectionViewCell {
    
    var comment: IGComment? {
        didSet {
            self.updateUI()
        }
    }
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        //        label.numberOfLines = 0
        //        label.backgroundColor = .lightGray
        textView.isScrollEnabled = false
        return textView
    }()
    
    let profileImageView: PFImageView = {
        let iv = PFImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .blue
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        backgroundColor = .yellow
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(textView)
        textView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
    }
    
    func updateUI()
    {
        guard let comment = comment else { return }
        
        let attributedText = NSMutableAttributedString(string: comment.userWhoPosted.username!, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: " " + comment.comment, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        
        textView.attributedText = attributedText
        
        if self.comment?.userWhoPosted.ProfilePicture != nil
        {
            profileImageView.backgroundColor = UIColor.lightGray
            profileImageView.file = self.comment?.userWhoPosted.ProfilePicture
            profileImageView.load(inBackground: { (image, error) -> Void in
                //self.ProfilePImageView.loadInBackground()
                //self.UsernameButton.setTitle(self.UserWhoPosted.username, for: UIControlState())
            }, progressBlock: { (percent) -> Void in
                //print(percent)
            })
        }
        else
        {
            profileImageView.backgroundColor = UIColor.lightGray
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
