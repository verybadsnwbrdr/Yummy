//
//  DataModel+CoreDataProperties.swift
//  Вкусно?
//
//  Created by Anton on 21.01.2023.
//
//

import Foundation
import CoreData


extension DataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataModel> {
        return NSFetchRequest<DataModel>(entityName: "DataModel")
    }

    @NSManaged public var uuid: String?
    @NSManaged public var name: String?
    @NSManaged public var recipeDescription: String?
    @NSManaged public var instructions: String?
    @NSManaged public var difficulty: Int16

}
