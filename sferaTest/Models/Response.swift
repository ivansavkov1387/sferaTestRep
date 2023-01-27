//
//  Response.swift
//  sferaTest
//
//  Created by Иван on 12/9/22.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let info: Info
    let results: [T]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}




