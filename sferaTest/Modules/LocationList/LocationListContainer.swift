//
//  LocationListContainer.swift
//  sferaTest
//
//  Created by Иван on 13.12.22.
//  
//

import UIKit

final class LocationListContainer {
    let input: LocationListModuleInput
	let viewController: UIViewController
	private(set) weak var router: LocationListRouterInput!

	static func assemble(with context: LocationListContext) -> LocationListContainer {
        let router = LocationListRouter()
        let interactor = LocationListInteractor(locationsNetworkService: context.moduleDependencies.networkService)
        let presenter = LocationListPresenter(router: router, interactor: interactor)
		let viewController = LocationListViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return LocationListContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: LocationListModuleInput, router: LocationListRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct LocationListContext {
    let moduleDependencies: ModuleDependencies
    weak var moduleOutput: LocationListModuleOutput?
}
