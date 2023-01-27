//
//  Character.swift
//  sferaTest
//
//  Created by Иван on 13.12.22.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Origin: Decodable {
    let name: String
    let url: String
}

struct CharacterLocation: Decodable {
    let name: String
    let url: String
}
