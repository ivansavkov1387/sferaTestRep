//
//  LocationListProtocols.swift
//  sferaTest
//
//  Created by Иван on 13.12.22.
//  
//

import Foundation

protocol LocationListModuleInput {
	var moduleOutput: LocationListModuleOutput? { get }
}

protocol LocationListModuleOutput: class {
}

protocol LocationListViewInput: class {
    func set(viewModels: [LocationCardViewModel])
}

protocol LocationListViewOutput: class {
    func viewDidLoad()
    func willDisplay(at index: Int)
}

protocol LocationListInteractorInput: class {
    func reload()
    func loadNext()
}

protocol LocationListInteractorOutput: class {
    func didEncounterError(_ error: Error)
    func didLoad(_ locations: [Location], loadType: LoadingDataType, count: Int)
}

protocol LocationListRouterInput: class {
}
