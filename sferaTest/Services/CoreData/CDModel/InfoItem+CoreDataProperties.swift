//
//  InfoItem+CoreDataProperties.swift
//  sferaTest
//
//  Created by Иван on 27.12.22.
//
//

import Foundation
import CoreData


extension InfoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InfoItem> {
        return NSFetchRequest<InfoItem>(entityName: "InfoItem")
    }

    @NSManaged public var characterCount: Int64
    @NSManaged public var characterPages: Int64
    @NSManaged public var episodeCount: Int64
    @NSManaged public var episodePages: Int64
    @NSManaged public var locationCount: Int64
    @NSManaged public var locationPages: Int64

}

extension InfoItem : Identifiable {

}
