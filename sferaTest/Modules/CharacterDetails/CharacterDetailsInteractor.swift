//
//  CharacterDetailsInteractor.swift
//  sferaTest
//
//  Created by Иван on 14.12.22.
//  
//

import Foundation

final class CharacterDetailsInteractor {
    weak var output: CharacterDetailsInteractorOutput?
    private let episodeNetworkService: NetworkServiceProtocol
    private lazy var episodes = [Episode]()
    
    init(episodeNetworkService: NetworkServiceProtocol) {
        self.episodeNetworkService = episodeNetworkService
    }
}

extension CharacterDetailsInteractor: CharacterDetailsInteractorInput {
    func load(_ episodes: [String]) {
        let queue = DispatchQueue.global(qos: .userInteractive)
        let group = DispatchGroup()
        for episode in episodes {
            group.enter()
            queue.async { [self] in
                self.episodeNetworkService.requestEpisode(url: episode) { [weak self] result in
                    defer { group.leave() }
                    guard let self = self else { return }
                    switch result {
                    case.success(let response):
                        self.episodes.append(response)
                    case .failure(let error):
                        self.output?.didEncounterError(error)
                    }
                }
            }
        }
        group.notify(queue: queue) { [self] in
            self.output?.didLoad(self.episodes)
        }
        
    }
    
}

