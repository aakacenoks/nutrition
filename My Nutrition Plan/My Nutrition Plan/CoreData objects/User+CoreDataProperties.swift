//
//  User+CoreDataProperties.swift
//  
//
//  Created by Andris Akačenoks on 18/06/2018.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var age: Int16
    @NSManaged public var gender: String?
    @NSManaged public var height: Int32
    @NSManaged public var weight: Int32

}
