//
//  CharacterDetailsPresenter.swift
//  sferaTest
//
//  Created by Иван on 14.12.22.
//  
//

import Foundation

final class CharacterDetailsPresenter {
    weak var view: CharacterDetailsViewInput?
    weak var moduleOutput: CharacterDetailsModuleOutput?
    private var episodes = [Episode]()
    
    private let router: CharacterDetailsRouterInput
    private let interactor: CharacterDetailsInteractorInput
    
    init(router: CharacterDetailsRouterInput, interactor: CharacterDetailsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CharacterDetailsPresenter: CharacterDetailsModuleInput {
}

extension CharacterDetailsPresenter: CharacterDetailsViewOutput {
    func viewDidLoad(_ episodes: [String]) {
        self.interactor.load(episodes)
    }
    
}

extension CharacterDetailsPresenter: CharacterDetailsInteractorOutput {
    
    func didLoad(_ episodes: [Episode]) {
        self.view?.set(viewModels: self.makeViewModels(episodes: episodes))
    }
    
    func didEncounterError(_ error: Error) {
    }
    
}

extension CharacterDetailsPresenter {
    func makeViewModels(episodes: [Episode]) -> [EpisodeViewModel] {
        return episodes.map { episode in
            EpisodeViewModel(name: episode.name,
                             airDate: episode.air_date,
                             episode: episode.episode)
        }
        
    }
}
