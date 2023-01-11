//
//  User+CoreDataProperties.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 10/1/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userName: String?
    @NSManaged public var userEmail: String?
    @NSManaged public var userPassword: String?
    @NSManaged public var userId: Int32
    @NSManaged public var userPost: NSSet?

}

// MARK: Generated accessors for userPost
extension User {

    @objc(addUserPostObject:)
    @NSManaged public func addToUserPost(_ value: Userpost)

    @objc(removeUserPostObject:)
    @NSManaged public func removeFromUserPost(_ value: Userpost)

    @objc(addUserPost:)
    @NSManaged public func addToUserPost(_ values: NSSet)

    @objc(removeUserPost:)
    @NSManaged public func removeFromUserPost(_ values: NSSet)

}

extension User : Identifiable {

}
