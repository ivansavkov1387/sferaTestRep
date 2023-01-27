//
//  CharacterListProtocols.swift
//  sferaTest
//
//  Created by Иван on 11/30/22.
//  
//

import Foundation

protocol CharacterListModuleInput {
	var moduleOutput: CharacterListModuleOutput? { get }
}

protocol CharacterListModuleOutput: class {
}

protocol CharacterListViewInput: class {
    func set(viewModels: [CharacterViewModel])
    
}

protocol CharacterListViewOutput: class {
    func viewDidLoad()
    func willDisplay(at index: Int)
    func onCellTap(with viewModel: CharacterViewModel)
}

protocol CharacterListInteractorInput: class {
    func reload()
    func loadNext()
    
}

protocol CharacterListInteractorOutput: class {
    func didEncounterError(_ error: Error)
    func didLoad(_ characters: [Character], loadType: LoadingDataType, count: Int, isOffline: Bool)
    
}

protocol CharacterListRouterInput: class {
    func showDetails(with viewModel: CharacterViewModel)

}
