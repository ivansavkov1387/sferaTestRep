//
//  CharacterListPresenter.swift
//  sferaTest
//
//  Created by Иван on 11/30/22.
//  
//

import Foundation

final class CharacterListPresenter {
    weak var moduleOutput: CharacterListModuleOutput?
    weak var view: CharacterListViewInput?
    private let router: CharacterListRouterInput
    private let interactor: CharacterListInteractorInput
    
    private var isNextPageLoading = false
    private var isReloading = false
    private var count: Int = 0
    
    private var characters: [Character] = []
    
    init(router: CharacterListRouterInput, interactor: CharacterListInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension CharacterListPresenter: CharacterListViewOutput {
    
    func viewDidLoad() {
        self.isReloading = true
        self.interactor.reload()
    }
    
    func willDisplay(at index: Int) {
        guard !self.isReloading,
              !self.isNextPageLoading,
              (self.characters.count - index) < 2, characters.count != self.count else {
            return
        }
        self.isNextPageLoading = true
        self.interactor.loadNext()
    }
    
    func onCellTap(with viewModel: CharacterViewModel) {
        self.router.showDetails(with: viewModel)
    }
    
} 

extension CharacterListPresenter: CharacterListInteractorOutput {
    
    func didEncounterError(_ error: Error) {
        print("CharacterListPresenter ERROR - \(error)")
    }
        
    func didLoad(_ characters: [Character], loadType: LoadingDataType, count: Int, isOffline: Bool) {
        switch loadType {
        case .reload:
            self.isReloading = false
            self.characters = characters
        case .nextPage:
            self.isNextPageLoading = false
            self.characters.append(contentsOf: characters)
        }
        self.count = count
        self.view?.set(viewModels: self.makeViewModels(characters: self.characters))
    }
    
}

private extension CharacterListPresenter {
    func makeViewModels(characters: [Character]) -> [CharacterViewModel] {
        return characters.map { character in
            CharacterViewModel(name: character.name ,
                                   status: character.status ,
                                   species: character.species ,
                                   imageURL: character.image,
                                   episodes: character.episode)
        }
    }
    
}

extension CharacterListPresenter: CharacterListModuleInput {
}
