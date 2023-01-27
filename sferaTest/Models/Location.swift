//
//  Location.swift
//  sferaTest
//
//  Created by Иван on 13.12.22.
//

import Foundation


struct Location: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    
}
