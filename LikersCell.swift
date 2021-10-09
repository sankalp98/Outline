//
//  LikersCell.swift
//  Outline
//
//  Created by Apple on 24/12/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LikersCell: UITableViewCell {
    
    @IBOutlet weak var ProfilePictureImageView: PFImageView!
    @IBOutlet weak var UsernameButton: UIButton!
    
    var indexPathForCell: IndexPath!
    
    var userWhoPosted: User!
    
    var userWhoLiked: User! {
        didSet {
            self.updateUI()
        }
    }
    
    var usersWhoLiked: [User]? {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        
        self.userWhoLiked.fetchInBackground { (object, error) -> Void in
            if error == nil
            {
                self.ProfilePictureImageView.file = self.userWhoLiked!.ProfilePicture
                self.ProfilePictureImageView.loadInBackground()
                if let gg = self.userWhoLiked!.username
                {
                    self.UsernameButton.setTitle(gg, for: UIControlState())
                }
                
                self.ProfilePictureImageView.layer.cornerRadius = self.ProfilePictureImageView.bounds.width / 2
                self.ProfilePictureImageView.clipsToBounds = true
                self.ProfilePictureImageView.layer.masksToBounds = true
            }
        }
        /*self.ProfilePictureImageView.file = self.userWhoLiked!.ProfilePicture
        self.ProfilePictureImageView.loadInBackground()
        if let gg = self.userWhoLiked!.username
        {
            self.UsernameButton.setTitle(gg, forState: UIControlState.Normal)
        }
        
        self.ProfilePictureImageView.layer.cornerRadius = self.ProfilePictureImageView.bounds.width / 2
        self.ProfilePictureImageView.clipsToBounds = true
        self.ProfilePictureImageView.layer.masksToBounds = true*/
    }
    


}
