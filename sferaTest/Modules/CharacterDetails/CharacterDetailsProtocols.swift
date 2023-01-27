//
//  CharacterDetailsProtocols.swift
//  sferaTest
//
//  Created by Иван on 14.12.22.
//  
//

import Foundation

protocol CharacterDetailsModuleInput {
	var moduleOutput: CharacterDetailsModuleOutput? { get }
}

protocol CharacterDetailsModuleOutput: class {

}

protocol CharacterDetailsViewInput: class {
    func set(viewModels: [EpisodeViewModel])
}

protocol CharacterDetailsViewOutput: class {
    func viewDidLoad(_ episodes: [String])
}

protocol CharacterDetailsInteractorInput: class {
    func load(_ episodes: [String])
}

protocol CharacterDetailsInteractorOutput: class {
    func didLoad(_ episodes: [Episode])
    func didEncounterError(_ error: Error)
}

protocol CharacterDetailsRouterInput: class {
    
    
}
