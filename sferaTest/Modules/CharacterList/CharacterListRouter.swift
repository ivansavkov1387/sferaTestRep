//
//  CharacterListRouter.swift
//  sferaTest
//
//  Created by Иван on 11/30/22.
//  
//

import UIKit

final class CharacterListRouter: BaseRouter {
    var viewController: UIViewController?
}

extension CharacterListRouter: CharacterListRouterInput {
    
    func showDetails(with viewModel: CharacterViewModel) {
        guard let moduleDependencies = moduleDependencies else { return }
        let context = CharacterDetailsContext(moduleDependencies: moduleDependencies, moduleOutput: self)
        let container = CharacterDetailsContainer.assemble(with: context, and: viewModel)
        self.navigationController?.pushViewController(container.viewController, animated: true)
    }
    
}

extension CharacterListRouter: CharacterDetailsModuleOutput {
}
