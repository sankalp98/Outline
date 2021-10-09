//
//  Follows.swift
//  Outline
//
//  Created by Apple on 09/11/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI

open class Follows: PFObject, PFSubclassing {
    
    private static var __once: () = {
            Follows.registerSubclass()
        }()
    
    @NSManaged open var Follower: User!
    @NSManaged open var Following: User!
    
    override init() {
        super.init()
    }
    
    init(xFollower:User!, xFollowing:User!)
    {
        super.init()
        self.Follower = xFollower
        self.Following = xFollowing
    }
    
    static let doInitialize : Void = {
        struct Static {
            static var onceToken: Int = 0
        }
        _ = Follows.__once
    }()
    
//    override open class func initialize()
//    {
//        struct Static {
//            static var onceToken: Int = 0
//        }
//        _ = Follows.__once
//    }
    
    open static func parseClassName() -> String {
        return "Follows"
    }
    
    func increaseFollowersCount()
    {
        if self.Following.xnumberOfFollowers >= 0
        {
            self.Following.xnumberOfFollowers += 1
            self.Following.saveInBackground()
        }
    }
    func decreaseFollowersCount()
    {
        if self.Following.xnumberOfFollowers > 0
        {
            self.Following.xnumberOfFollowers = self.Following.xnumberOfFollowers-1
            self.Following.saveInBackground(block: { (success, error) -> Void in
                if error == nil
                {
                    //..
                }
                else
                {
                    //..
                }
            })
        }
        else
        {
            //..
        }
    }
    
    func increaseFollowingsCount()
    {
        if self.Follower.xnumberOfFollowings >= 0
        {
            self.Follower.xnumberOfFollowings += 1
            self.Follower.saveInBackground()
        }
    }
    func decreaseFollowingsCount()
    {
        if self.Follower.xnumberOfFollowings > 0
        {
            self.Follower.xnumberOfFollowings -= 1
            self.Follower.saveInBackground()
        }
        if self.Follower.xnumberOfFollowers < 0
        {
            self.Follower.xnumberOfFollowings == 0
            self.Follower.saveInBackground()
        }
    }
    
}
