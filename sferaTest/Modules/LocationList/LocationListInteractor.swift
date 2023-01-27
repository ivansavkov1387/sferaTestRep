//
//  LocationListInteractor.swift
//  sferaTest
//
//  Created by Иван on 13.12.22.
//  
//

import Foundation

final class LocationListInteractor {
    weak var output: LocationListInteractorOutput?
    private let locationsNetworkService: NetworkServiceProtocol
    
    private var page: Int = GlobalConstants.initialPage
    private var params: LocationsRequestParams
    
    init(locationsNetworkService: NetworkServiceProtocol) {
        self.locationsNetworkService = locationsNetworkService
        self.params = LocationsRequestParams(page: String(page))
    }
    
}

extension LocationListInteractor: LocationListInteractorInput {
    func reload() {
        self.page = GlobalConstants.initialPage
        self.params = LocationsRequestParams(page: String(self.page))
        self.load()
    }
    
    func loadNext() {
        self.load()
    }
    
}

private extension LocationListInteractor {
    func load() {
        self.locationsNetworkService.requestLocations(params: params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let maxPage = response.info.pages
                let maxCount = response.info.count
                self.output?.didLoad(response.results, loadType: self.page == GlobalConstants.initialPage ? .reload : .nextPage, count: maxCount)
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
    
}
