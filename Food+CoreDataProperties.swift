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
    @NSManaged public var url: String?
    @NSManaged public var rating: Int64
    @NSManaged public var prices: Int64
    @NSManaged public var oldPrice: Int64
    @NSManaged public var imageD: Data?
    @NSManaged public var date: Date?
    
    @NSManaged public var comment: NSSet?

    public var commentArray : [Comment] {
        let set = comment as? Set<Comment> ?? []
        
        return set.sorted {
            $0.commentName.count > $1.commentName.count
        }
    }
}
