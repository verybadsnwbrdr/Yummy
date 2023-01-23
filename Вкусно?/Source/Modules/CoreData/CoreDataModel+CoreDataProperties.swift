//
//  CoreDataModel+CoreDataProperties.swift
//  Вкусно?
//
//  Created by Anton on 23.01.2023.
//
//

import Foundation
import CoreData


extension CoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataModel> {
        return NSFetchRequest<CoreDataModel>(entityName: "CoreDataModel")
    }

    @NSManaged public var name: String?

}
