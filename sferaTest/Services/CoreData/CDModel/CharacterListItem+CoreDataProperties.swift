//
//  CharacterListItem+CoreDataProperties.swift
//  sferaTest
//
//  Created by Иван on 27.12.22.
//
//

import Foundation
import CoreData


extension CharacterListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterListItem> {
        return NSFetchRequest<CharacterListItem>(entityName: "CharacterListItem")
    }

    @NSManaged public var created: String
    @NSManaged public var episode: [String]
    @NSManaged public var gender: String
    @NSManaged public var id: Int64
    @NSManaged public var image: String
    @NSManaged public var location: [String:String]
    @NSManaged public var name: String
    @NSManaged public var origin: [String:String]
    @NSManaged public var species: String
    @NSManaged public var status: String
    @NSManaged public var type: String
    @NSManaged public var url: String

}

extension CharacterListItem : Identifiable {

}
