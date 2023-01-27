//
//  URLFactory.swift
//  sferaTest
//
//  Created by Иван on 12/7/22.
//

import Foundation

enum URLFactory {
    private static var baseURL: URL {
        return baseUrlComponents.url!
    }
    private static let baseUrlComponents: URLComponents = {
        let url = URL(string: "https://rickandmortyapi.com/api")!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = []
        return urlComponents
    }()
    
    static func characters(params: CharactersRequestParams) -> String {
        var urlComponents = baseUrlComponents
        let params = [URLQueryItem(name: "page", value: params.page)]
        urlComponents.queryItems?.append(contentsOf: params)
        return urlComponents.url!.appendingPathComponent("character").absoluteString
    }
    
    static func locations(params: LocationsRequestParams) -> String {
        var urlComponents = baseUrlComponents
        let params = [URLQueryItem(name: "page", value: params.page)]
        urlComponents.queryItems?.append(contentsOf: params)
        return urlComponents.url!.appendingPathComponent("location").absoluteString
    }
    
}
