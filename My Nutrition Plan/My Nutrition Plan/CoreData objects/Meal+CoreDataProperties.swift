//
//  Meal+CoreDataProperties.swift
//  
//
//  Created by Andris Akačenoks on 13/06/2018.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var lunchItem: String?
    @NSManaged public var breakfastItem: String?
    @NSManaged public var dinnerItem: String?
    @NSManaged public var snackItem: String?
    @NSManaged public var drinkItem: String?

}
