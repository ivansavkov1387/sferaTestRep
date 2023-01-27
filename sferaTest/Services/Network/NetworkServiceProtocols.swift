//
//  NetworkServiceProtocols.swift
//  sferaTest
//
//  Created by Иван on 12/7/22.
//

import Foundation

struct CharactersRequestParams: Decodable {
    var page: String?
}

struct LocationsRequestParams: Decodable {
    var page: String?
}

struct EpisodesRequestParams: Decodable {
    var episodeNumber: String?
}


protocol NetworkServiceProtocol {
    func requestCharacters(params: CharactersRequestParams, completion: @escaping (Result<Response<Character>, Error>) -> Void)
    
    func requestLocations(params: LocationsRequestParams, completion: @escaping (Result<Response<Location>, Error>) -> Void)
    
    func requestEpisode(url: String, completion: @escaping (Result<Episode, Error>) -> Void)
}




