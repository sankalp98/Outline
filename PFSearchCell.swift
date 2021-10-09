//
//  PFSearchCell.swift
//  Outline
//
//  Created by Apple on 09/11/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI

protocol xxxMyCustomCellDelegator {
    func xxxcallSegueFromCell(_ xxUser: User)
}

class PFSearchCell: PFTableViewCell {

    var user: User! {
        didSet {
            self.updateUI()
        }
    }
    
    var nola: User = User()
    
    var xxdelegate:xxxMyCustomCellDelegator!
    
    @IBOutlet weak var xProfileImageView: PFImageView!
    
    //@IBOutlet weak var xyProfileImageView: PFImageView!
    @IBOutlet weak var xUsernameButton: DesignableButton!
    
    func updateUI()
    {
        if self.user.ProfilePicture != nil
        {
            self.xProfileImageView.file = self.user.ProfilePicture
            self.xProfileImageView.layer.cornerRadius = xProfileImageView.bounds.width / 2
            self.xProfileImageView.clipsToBounds = true
            self.xProfileImageView.layer.masksToBounds = true
            self.xProfileImageView.load(inBackground: { (image, error) -> Void in
                if error == nil
                {
                    self.xProfileImageView.image = image
                }
                }) { (progress) -> Void in
                    //..
            }
        }
        
        if let xyz = self.user.username
        {
            xUsernameButton.setTitle("\(xyz)", for: UIControlState())
            //self.xUsernameButton.addTarget(self, action: "UsernameClicked", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        self.xUsernameButton.isUserInteractionEnabled = false
        self.xProfileImageView.isUserInteractionEnabled = false
    }
    
    @IBAction func UsernameClicked()
    {
        
        print("Username is clicked")
        
        if self.xxdelegate != nil
        {
            self.xxdelegate.xxxcallSegueFromCell(self.user)
        }
        else
        {
            print("xxdelegate is nil")
        }
        
    }
    
    
    @IBAction func UsernameClicked(_ sender: AnyObject) {
        
        
    }

}
