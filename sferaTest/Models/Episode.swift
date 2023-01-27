//
//  Episode.swift
//  sferaTest
//
//  Created by Иван on 19.12.22.
//

import Foundation

struct Episode: Decodable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let created: String
    let url: String
}
