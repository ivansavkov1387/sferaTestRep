//
//  NetworkService.swift
//  sferaTest
//
//  Created by Иван on 12/7/22.
//

import Foundation

class NetworkService {
    
    func baseRequest<T: Decodable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: url) else {
            completion(.failure(NetwokError.wrongUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetwokError.dataIsNil))
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedObject = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedObject))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
}

enum NetwokError: Error {
    case wrongUrl
    case dataIsNil
}
