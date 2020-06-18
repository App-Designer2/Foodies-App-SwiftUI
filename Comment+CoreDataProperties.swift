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
    @NSManaged public var hour: String?
    @NSManaged public var date: Date?
    @NSManaged public var food: Food?
    
    public var commentName: String {
        comment ?? "App Designer2"
    }

}
