//
//  Gathering.swift
//  Outline
//
//  Created by Apple on 09/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

open class Gathering: PFObject, PFSubclassing, ListDiffable {
    
    private static var __once: () = {
        Gathering.registerSubclass()
    }()
    
    @NSManaged open var nameGathering: String!
    @NSManaged open var venueName: String!
    @NSManaged open var Gatheringdescription: String!
    @NSManaged open var imageGathering: PFFile!
    @NSManaged open var startDate: Date!
    @NSManaged open var endDate: Date!
    @NSManaged open var location: PFGeoPoint!
    @NSManaged open var UserWhoCreated: User!
    override init() {
        super.init()
    }
    
    init(nameGathering: String!, venueName: String!, GatheringDescription: String!, imageGathering: PFFile!, startDate: Date!, endDate: Date!, xlocation:PFGeoPoint!, xUserWhoPosted: User!)
    {
        super.init()
        
        self.nameGathering = nameGathering
        self.venueName = venueName
        self.Gatheringdescription = GatheringDescription
        self.imageGathering = imageGathering!
        self.startDate = startDate
        self.endDate = endDate
        self.location = xlocation
        self.UserWhoCreated = xUserWhoPosted
    }
    
    static let doInitialize : Void = {
        struct Static {
            static var onceToken: Int = 0
        }
        _ = Gathering.__once
    }()
    
//    override open class func initialize()
//    {
//        struct Static {
//            static var onceToken: Int = 0
//        }
//        _ = Gathering.__once
//    }
    
    open static func parseClassName() -> String {
        return "Gathering"
    }
    
    public static func ==(lhs: Gathering, rhs: Gathering) -> Bool
    {
        return rhs.objectId == lhs.objectId
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard  let object = object as? Gathering else {return false}
        return self.objectId == object.objectId
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return objectId! as NSObjectProtocol
}
}

