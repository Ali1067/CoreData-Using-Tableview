//
//  Person+CoreDataProperties.swift
//  CoreDataPractice
//
//  Created by Zoom Digital on 12/08/2021.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int64
    @NSManaged public var gender: String?

}

extension Person : Identifiable {

}
