//
//  LocationListPresenter.swift
//  sferaTest
//
//  Created by Иван on 13.12.22.
//  
//

import Foundation

final class LocationListPresenter {
    weak var moduleOutput: LocationListModuleOutput?
    weak var view: LocationListViewInput?
    private let router: LocationListRouterInput
    private let interactor: LocationListInteractorInput
    
    private var isNextPageLoading = false
    private var isReloading = false
    private var count: Int = 0
    
    private var locations: [Location] = []
    
    init(router: LocationListRouterInput, interactor: LocationListInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LocationListPresenter: LocationListViewOutput {
    func viewDidLoad() {
        self.isReloading = true
        self.interactor.reload()
    }
    
    func willDisplay(at index: Int) {
        guard !self.isReloading,
              !self.isNextPageLoading,
              (self.locations.count - index) < 10, locations.count != self.count else {
            return
        }
        self.isNextPageLoading = true
        self.interactor.loadNext()
    }
    
}

extension LocationListPresenter: LocationListInteractorOutput {
    func didEncounterError(_ error: Error) {
        print("LocationListPresenter ERROR - \(error)")
    }
    
    func didLoad(_ locations: [Location], loadType: LoadingDataType, count: Int) {
        switch loadType {
        case .reload:
            self.isReloading = false
            self.locations = locations
        case .nextPage:
            self.isNextPageLoading = false
            self.locations.append(contentsOf: locations)
        }
        self.count = count
        self.view?.set(viewModels: self.makeViewModels(locations: self.locations))
    }
    
}

extension LocationListPresenter: LocationListModuleInput {
}

private extension LocationListPresenter {
    func makeViewModels(locations: [Location]) -> [LocationCardViewModel] {
        return locations.map { location in
            LocationCardViewModel(name: location.name,
                                  type: location.type)
        }
    }
    
}
