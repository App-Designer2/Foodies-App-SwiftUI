//
//  Comment+CoreDataProperties.swift
//  Foodies
//
//  Created by App Designer2 on 15.06.20.
//  Copyright © 2020 App Designer2. All rights reserved.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var comment: String?
    @NSManaged public var profile: Data?
    @NSManaged public var date: Date?
    @NSManaged public var food: NSSet?

    public var commentName : String {
        comment ?? ""
    }
}

// MARK: Generated accessors for food
extension Comment {

    @objc(addFoodObject:)
    @NSManaged public func addToFood(_ value: Food)

    @objc(removeFoodObject:)
    @NSManaged public func removeFromFood(_ value: Food)

    @objc(addFood:)
    @NSManaged public func addToFood(_ values: NSSet)

    @objc(removeFood:)
    @NSManaged public func removeFromFood(_ values: NSSet)

    
}
