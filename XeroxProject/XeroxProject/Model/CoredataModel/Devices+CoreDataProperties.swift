//
//  Devices+CoreDataProperties.swift
//  XeroxProject
//
//  Created by Nishanth on 07/08/24.
//
//

import Foundation
import CoreData


extension Devices {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Devices> {
        return NSFetchRequest<Devices>(entityName: "Devices")
    }

    @NSManaged public var deviceName: String?
    @NSManaged public var ipAddress: String?
    @NSManaged public var status: String?

}

extension Devices : Identifiable {

}
