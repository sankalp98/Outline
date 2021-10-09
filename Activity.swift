//
//  Activity.swift
//  Outline
//
//  Created by Apple on 10/03/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

open class Activity: PFObject, PFSubclassing, ListDiffable {
    
    private static var __once: () = {
        Activity.registerSubclass()
    }()
    
    
    @NSManaged open var UserWhoInitiatedActivity: User!
    @NSManaged open var UserOnWhomActivtyIsDone: User!
    @NSManaged open var OnPost: Post!
    open var isALike: Int!
    open var isAComment: Int!
    @NSManaged open var numberIfALike: Int
    @NSManaged open var numberIfAComment: Int
    
    override init() {
        super.init()
    }
    
    init(UserWhoInitiatedActivity: User!, UserOnWhomActivtyIsDone: User!, OnPost: Post!, numberIfALike: Int!, numberIfAComment: Int!)
    {
        super.init()
        self.UserWhoInitiatedActivity = UserWhoInitiatedActivity
        self.UserOnWhomActivtyIsDone = UserOnWhomActivtyIsDone
        self.OnPost = OnPost
        self.numberIfALike = numberIfALike
        self.numberIfAComment = numberIfAComment
        
        
    }
    
    static let doInitialize : Void = {
        struct Static {
            static var onceToken: Int = 0
        }
        _ = Activity.__once
    }()
    
//    override open class func initialize()
//    {
//        struct Static {
//            static var onceToken: Int = 0
//        }
//        _ = Activity.__once
//    }
    
    open static func parseClassName() -> String {
        return "Activity"
    }
    
    public static func ==(lhs: Activity, rhs: Activity) -> Bool
    {
        return rhs.objectId == lhs.objectId
    }
    
//    open override func object(forKey key: String) -> Any? {
//
//    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard  let object = object as? Activity else {return false}
        return self.objectId == object.objectId
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return objectId! as NSObjectProtocol
    }
    
}
