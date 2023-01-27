//
//  CharacterDetailsContainer.swift
//  sferaTest
//
//  Created by Иван on 14.12.22.
//  
//

import UIKit

final class CharacterDetailsContainer {
    let input: CharacterDetailsModuleInput
	let viewController: UIViewController
	private(set) weak var router: CharacterDetailsRouterInput!

    static func assemble(with context: CharacterDetailsContext, and viewModel: CharacterViewModel) -> CharacterDetailsContainer {
        let router = CharacterDetailsRouter()
        let interactor = CharacterDetailsInteractor(episodeNetworkService: context.moduleDependencies.networkService)
        let presenter = CharacterDetailsPresenter(router: router, interactor: interactor)
        let viewController = CharacterDetailsViewController(output: presenter, characterViewModel: viewModel)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return CharacterDetailsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: CharacterDetailsModuleInput, router: CharacterDetailsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct CharacterDetailsContext {
    let moduleDependencies: ModuleDependencies
	weak var moduleOutput: CharacterDetailsModuleOutput?
}
