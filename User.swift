//
//  User.swift
//  Outline
//
//  Created by Apple on 30/10/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

open class User: PFUser, ListDiffable {
    
    private static var __once: () = {
            User.registerSubclass()
        }()
    
    @NSManaged open var ProfilePicture: PFFile?
    @NSManaged open var CoverPicture: PFFile?
    @NSManaged open var Status: String?
    @NSManaged open var xnumberOfFollowers: Int
    @NSManaged open var xnumberOfFollowings: Int
    @NSManaged open var xnumberOfPosts: Int
    
    override init() {
        super.init()
    }
    
    static let doInitialize : Void = {
        struct Static {
            static var onceToken: Int = 0
        }
        _ = User.__once
    }()
    
//    override open class func initialize()
//    {
//        struct Static {
//            static var onceToken: Int = 0
//        }
//        _ = User.__once
//    }
    
    public static func ==(lhs: User, rhs: User) -> Bool
    {
        return rhs.objectId == lhs.objectId
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard  let object = object as? User else {return false}
        return self.objectId == object.objectId
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return objectId! as NSObjectProtocol
    }
}
