//
//  Comment.swift
//  BaeToBye
//
//  Created by Apple on 10/08/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

import UIKit
import IGListKit
import Parse

open class Comment: PFObject, PFSubclassing, ListDiffable
{
    
    private static var __once: () = {
            Comment.registerSubclass()
        }()
    
    @NSManaged open var post: Post!
    @NSManaged open var userWhoCommented: User!
    @NSManaged open var commentText:String!
    
    
    override init() {
        super.init()
    }
    
    init(post:Post, userWhoCommented: User, commentText:String!)
    {
        super.init()
        self.post = post
        self.userWhoCommented = userWhoCommented
        self.commentText = commentText
    }
    
    static let doInitialize : Void = {
        struct Static {
            static var onceToken : Int = 0;
        }
        _ = Comment.__once
    }()
    
//    override open class func initialize() {
//        struct Static {
//            static var onceToken : Int = 0;
//        }
//        _ = Comment.__once
//    }
    
    open static func parseClassName() -> String
    {
        return "Comment"
    }
    
    public static func ==(lhs: Comment, rhs: Comment) -> Bool
    {
        return rhs.objectId == lhs.objectId
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard  let object = object as? Comment else {return false}
        return self.objectId == object.objectId
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return objectId! as NSObjectProtocol
    }
    
    open func DoIt(_ xobjectId: String, xnumberOfCOmments: Int)
    {
        let query = PFQuery(className: "Posts")
        query.whereKey("objectId", equalTo: xobjectId)
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil
            {
                for xobject in objects!
                {
                    xobject.incrementKey("numberOfComments", byAmount: 1)
                    xobject.saveInBackground()
                }
            }
            else
            {
                print("error")
            }
        }
    }
    
    
    
}
