//
//  CharacterListContainer.swift
//  sferaTest
//
//  Created by Иван on 11/30/22.
//  
//

import UIKit
import Foundation

final class CharacterListContainer {
    let input: CharacterListModuleInput
	let viewController: UIViewController
	private(set) weak var router: CharacterListRouterInput!

	static func assemble(with context: CharacterListContext) -> CharacterListContainer {
        let router = CharacterListRouter()
        let interactor = CharacterListInteractor(charactersNetworkService: context.moduleDependencies.networkService, cdStack: context.moduleDependencies.cdStack)
        let presenter = CharacterListPresenter(router: router, interactor: interactor)
		let viewController = CharacterListViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        
        router.navigationControllerProvider = { [weak viewController] in
            viewController?.navigationController
        }
        
        router.moduleDependencies = (context.moduleDependencies as! AppDependency)
        
        

        return CharacterListContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: CharacterListModuleInput, router: CharacterListRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct CharacterListContext {
    let moduleDependencies: ModuleDependencies
	weak var moduleOutput: CharacterListModuleOutput?
}
