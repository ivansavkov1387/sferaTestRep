//
//  CharacterListInteractor.swift
//  sferaTest
//
//  Created by Иван on 11/30/22.
//  
//

import Foundation

final class CharacterListInteractor {
    weak var output: CharacterListInteractorOutput?
    private let charactersNetworkService: NetworkServiceProtocol
    private let cdStack: CDStackProtocol
    
    private var page: Int = GlobalConstants.initialPage
    private var params: CharactersRequestParams
    
    init(charactersNetworkService: NetworkServiceProtocol, cdStack: CDStackProtocol) {
        self.charactersNetworkService = charactersNetworkService
        self.cdStack = cdStack
        self.params = CharactersRequestParams(page: String(self.page))
    }
    
}

extension CharacterListInteractor: CharacterListInteractorInput {
    func reload() {
        self.page = GlobalConstants.initialPage
        self.params = CharactersRequestParams(page: String(self.page))
        self.load()
        }

    func loadNext() {
        self.load()
    }
    
}

private extension CharacterListInteractor {
    func load() {
        self.charactersNetworkService.requestCharacters(params: params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let maxPage = response.info.pages
                let maxCount = response.info.count
                self.output?.didLoad(response.results, loadType: self.page == GlobalConstants.initialPage ? .reload : .nextPage, count: maxCount, isOffline: false)
                if self.page == maxPage {
                    self.page = maxPage
                } else {
                    self.page += 1
                }
                self.params.page = String(self.page)
                
            case .failure(let error):
                self.output?.didEncounterError(error)
            }
        }
    }
    
    
    func loadOffline() {
        let results = cdStack.fetchCharactersModels(with: page)
        let infoTable = cdStack.fetchInfoModels().first
        
        var charactersModels: [Character] = []
        
        for result in results {
            let dictOrigin = result.origin
            let key = Array(dictOrigin.keys)[0]
            let origin = Origin(name: key,
                                url: dictOrigin[key] ?? "")
            
            let dictLocation = result.location
            let locationKey = Array(dictLocation.keys)[0]
            let location = CharacterLocation(name: locationKey,
                                             url: dictLocation[locationKey] ?? "")
            
            let character = Character(id: Int(result.id),
                                      name: result.name,
                                      status: result.status,
                                      species: result.species,
                                      type: result.type,
                                      gender: result.gender,
                                      origin: origin,
                                      location: location,
                                      image: result.image,
                                      episode: result.episode,
                                      url: result.url,
                                      created: result.created)
            charactersModels.append(character)
            
        }
        if !charactersModels.isEmpty {
            output?.didLoad(charactersModels, loadType: page == GlobalConstants.initialPage ? .reload : .nextPage, count: Int(infoTable?.characterCount ?? 0), isOffline: true)
            
            if page == Int(infoTable?.characterPages ?? 0) {
                page = Int(infoTable?.characterPages ?? 0)
            } else {
                page += 1
            }
            params.page = String(page)
        } else {
//            output?.didError(with: NetworkErrors.dataIsEmpty)
        }
    }
    
}
