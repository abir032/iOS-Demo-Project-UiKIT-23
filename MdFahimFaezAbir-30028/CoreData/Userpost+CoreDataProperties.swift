//
//  Userpost+CoreDataProperties.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 10/1/23.
//
//

import Foundation
import CoreData


extension Userpost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Userpost> {
        return NSFetchRequest<Userpost>(entityName: "Userpost")
    }

    @NSManaged public var createDate: Date?
    @NSManaged public var imagePath: Data?
    @NSManaged public var post: String?
    @NSManaged public var updateDate: Date?
    @NSManaged public var userId: User?

}

extension Userpost : Identifiable {

}
