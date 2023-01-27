//
//  AppCoordinator.swift
//  sferaTest
//
//  Created by Иван on 12/6/22.
//
import UIKit

class AppCoordinator {
      
    let appDependency: AppDependency
    private let window: UIWindow
    private lazy var tabbarController = UITabBarController()
    private lazy var navigationControllers = AppCoordinator.makeNavigationControllers()
    
    init(window: UIWindow, appDependency: AppDependency) {
        self.appDependency = appDependency
        
        self.window = window
        self.navigationControllers = AppCoordinator.makeNavigationControllers()
        self.setupAppearance()
    }
    
    func start() {
        self.setupCharacters()
        self.setupLocations()
        let navigationControllers = NavControllerType.allCases.compactMap { self.navigationControllers[$0] }
        self.tabbarController.setViewControllers(navigationControllers, animated: false)
        window.rootViewController = self.tabbarController
        window.makeKeyAndVisible()
    }
    
}

private extension AppCoordinator {
    
    static func makeNavigationControllers() -> [NavControllerType: UINavigationController] {
        var result: [NavControllerType: UINavigationController] = [:]
        NavControllerType.allCases.forEach { (navControllerKey) in
            let navigationController = UINavigationController()
            let tabbarItem = UITabBarItem(title: navControllerKey.title,
                                          image: navControllerKey.image,
                                          tag: navControllerKey.rawValue)
            navigationController.tabBarItem = tabbarItem
            navigationController.navigationBar.prefersLargeTitles = true

            result[navControllerKey] = navigationController
        }
        return result
    }
    
    func setupCharacters() {
        guard let navController = navigationControllers[.characters] else {
            fatalError("cant find navController")
        }
        let context = CharacterListContext(moduleDependencies: self.appDependency,
                                           moduleOutput: nil)
        let container = CharacterListContainer.assemble(with: context)
        
        navController.setViewControllers([container.viewController], animated: false)
        container.viewController.navigationItem.title = NavControllerType.characters.title
    }
    
    func setupLocations() {
        guard let navController = navigationControllers[.locations] else {
            fatalError("cant find navController")
        }
        let context = LocationListContext(moduleDependencies: self.appDependency,
                                          moduleOutput: nil)
        let container = LocationListContainer.assemble(with: context)
        navController.setViewControllers([container.viewController], animated: false)
        container.viewController.navigationItem.title = NavControllerType.locations.title
    }
        
    func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = Styles.Color.appGreen

    }
}

fileprivate enum NavControllerType: Int, CaseIterable {
    case characters, locations
    
    var title: String {
        switch self {
        case .characters: return Localization.characters
        case .locations: return Localization.locations
        
        }
    }
    
    var image: UIImage? {
        switch self {
        case .characters: return UIImage(systemName: "person.3.fill")
        case .locations: return UIImage(systemName: "location.fill")
        }
    }

}

