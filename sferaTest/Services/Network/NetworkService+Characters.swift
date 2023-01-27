//
//  NetworkService+Characters.swift
//  sferaTest
//
//  Created by Иван on 12/7/22.
//

import Foundation

extension NetworkService: NetworkServiceProtocol {
    func requestCharacters(params: CharactersRequestParams, completion: @escaping (Result<Response<Character>, Error>) -> Void) {
        let url = URLFactory.characters(params: params)
        self.baseRequest(url: url, completion: completion)
    }
    
    func requestLocations(params: LocationsRequestParams, completion: @escaping (Result<Response<Location>, Error>) -> Void) {
        let url = URLFactory.locations(params: params)
        self.baseRequest(url: url, completion: completion)
    }
    
    func requestEpisode(url: String, completion: @escaping (Result<Episode, Error>) -> Void) {
        self.baseRequest(url: url, completion: completion)
    }
    
    
        
    
    
}
