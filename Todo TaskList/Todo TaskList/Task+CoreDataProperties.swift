//
//  TaskEntity+CoreDataProperties.swift
//  Todo TaskList
//
//  Created by Meet Shah on 12/03/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: String?
    @NSManaged public var day: String?
    @NSManaged public var month: String?
    @NSManaged public var alert: Bool
    @NSManaged public var isCompleted: Bool

}

extension Task : Identifiable {

}
