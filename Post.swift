//
//  Post.swift
//  BaeToBye
//
//  Created by Apple on 24/07/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

import UIKit
import Parse
import IGListKit

open class Post: PFObject, PFSubclassing, ListDiffable {
    
    private static var __once: () = {
        Post.registerSubclass()
        }()
    
    @NSManaged open var shares: String!
    @NSManaged open var userID: String!
    @NSManaged open var ImageFiles: PFFile?
    @NSManaged open var numberOfLikes: Int
    @NSManaged open var numberOfComments: Int
    @NSManaged open var likerIds: [String]!
    @NSManaged open var likers: [User]!
    @NSManaged open var location: PFGeoPoint!
    @NSManaged open var locationName: String!
    @NSManaged open var UserWhoPosted: User!
    open var isALocation: Bool!
    @NSManaged open var numberIfLocation: Int
    @NSManaged open var numberIfStatus: Int
    @NSManaged open var numberIfPhoto: Int
    @NSManaged open var numberIfCheckIn: Int
    @NSManaged open var isMapShown: Int
    @NSManaged open var gathering: Gathering?
    
    override init() {
        super.init()
    }
    
    init(shares:String, userID:String, xImageFile: PFFile?, numberOfLikes:Int?, xlocation:PFGeoPoint!, xUserWhoPosted: User!, numberOfComments:Int?, isALocation: Bool!, locationName: String, numberIfLocation: Int, numberIfStatus: Int, numberIfPhoto: Int, numberIfCheckIn: Int, isMapShown: Int, gathering: Gathering?)
    {
        super.init()
        
        if xImageFile != nil {
            self.ImageFiles = xImageFile
        } else {
            self.ImageFiles = nil
        }
        
        if xlocation != nil
        {
            self.location = xlocation
        }
        else
        {
            self.location = nil
        }
        
        self.shares = shares
        self.userID = userID
        self.numberOfLikes = numberOfLikes!
        self.numberOfComments = numberOfComments!
        self.likerIds = [String]()
        self.likers = [User]()
        self.UserWhoPosted = xUserWhoPosted
        self.isALocation = isALocation!
        self.locationName = locationName
        self.numberIfLocation = numberIfLocation
        self.numberIfStatus = numberIfStatus
        self.numberIfPhoto = numberIfPhoto
        self.numberIfCheckIn = numberIfCheckIn
        self.isMapShown = isMapShown
        self.gathering = gathering
    }
    
    static let doInitialize : Void = {
        struct Static {
            static var onceToken: Int = 0
        }
        _ = Post.__once
    }()
    
//    override open class func initialize()
//    {
//        struct Static {
//            static var onceToken: Int = 0
//        }
//        _ = Post.__once
//    }
    
    open static func parseClassName() -> String {
        return "Posts"
    }
    
    public static func ==(lhs: Post, rhs: Post) -> Bool
    {
        return rhs.objectId == lhs.objectId
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard  let object = object as? Post else {return false}
        return self.userID == object.userID
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return objectId! as NSObjectProtocol
    }
    
    open func like()
    {
        let currentUserId = PFUser.current()?.objectId
        if !likerIds.contains((currentUserId!))
        {
            numberOfLikes += 1
            likerIds.insert(currentUserId!, at: 0)
            let xcurrentUser = User.current()
            if !likers.contains((xcurrentUser!))
            {
                likers.insert(xcurrentUser!, at: 0)
                self.saveInBackground()
            }
            self.saveInBackground()
        }
    }
    
    open func dislike()
    {
        let currentUserId = PFUser.current()?.objectId
        if let ids = likerIds
        {
            if ids.contains((currentUserId!))
            {
                numberOfLikes -= 1
                for(index, name) in likerIds.enumerated()
                {
                    if name == currentUserId
                    {
                        likerIds.remove(at: index)
                        break
                    }
                }
                self.saveInBackground()
            }
        }
        
        let ycurrentUser = User.current()
        if let xlikers = likers
        {
            if xlikers.contains((ycurrentUser!))
            {
                for(index, name) in likers.enumerated()
                {
                    if name == ycurrentUser
                    {
                        likers.remove(at: index)
                        break
                    }
                }
                self.saveInBackground()
            }
        }
    }
    
}
