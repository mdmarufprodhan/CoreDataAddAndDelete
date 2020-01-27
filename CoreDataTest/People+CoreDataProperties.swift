//
//  People+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by Md Maruf Prodhan on 1/23/20.
//  Copyright © 2020 Md Maruf Prodhan. All rights reserved.
//
//

import Foundation
import CoreData


extension People {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<People> {
        return NSFetchRequest<People>(entityName: "People")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
