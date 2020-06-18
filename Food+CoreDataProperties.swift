//
//  Food+CoreDataProperties.swift
//  Foodies
//
//  Created by App Designer2 on 15.06.20.
//  Copyright © 2020 App Designer2. All rights reserved.
//
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var items: String?
    @NSManaged public var detail: String?
    @NSManaged public var msg: String?
    @NSManaged public var rating: Int64
    @NSManaged public var offer: Int64
    @NSManaged public var imageD: Data?
    @NSManaged public var date: Date?
    @NSManaged public var prices: String?
    @NSManaged public var before: String?
    @NSManaged public var comment: NSSet?
    
    public var commentArray : [Comment] {
        let set = comment as? Set<Comment> ?? []
        
        return set.sorted {
            $0.commentName.count > $1.commentName.count
        }
    }

}

// MARK: Generated accessors for comment
extension Food {

    @objc(addCommentObject:)
    @NSManaged public func addToComment(_ value: Comment)

    @objc(removeCommentObject:)
    @NSManaged public func removeFromComment(_ value: Comment)

    @objc(addComment:)
    @NSManaged public func addToComment(_ values: NSSet)

    @objc(removeComment:)
    @NSManaged public func removeFromComment(_ values: NSSet)

}
