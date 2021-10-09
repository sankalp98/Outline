//
//  IGComment.swift
//  Outline
//
//  Created by Apple on 28/01/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Parse
import IGListKit

open class IGComment: PFObject, PFSubclassing, ListDiffable {
    
    private static var __once: () = {
        IGComment.registerSubclass()
    }()
    
    @NSManaged open var post: Post!
    @NSManaged open var userWhoPosted: User!
    @NSManaged open var comment: String!
    
    override init() {
        super.init()
    }
    
    init(post:Post, userWhoPosted:User, comment: String)
    {
        super.init()
        
        self.post = post
        self.userWhoPosted = userWhoPosted
        self.comment = comment
    }
    
    static let doInitialize : Void = {
        struct Static {
            static var onceToken: Int = 0
        }
        _ = IGComment.__once
    }()
    
    open static func parseClassName() -> String {
        return "IGComment"
    }
    
    public static func ==(lhs: IGComment, rhs: IGComment) -> Bool
    {
        return rhs.objectId == lhs.objectId
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard  let object = object as? IGComment else {return false}
        return self.objectId == object.objectId
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self.comment! as NSObjectProtocol
    }
    
}
