//
//  SceneDelegate.swift
//  sferaTest
//
//  Created by Иван on 11/30/22.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private lazy var appDependency: AppDependency = AppDependency.makeDefault()
    private var appCoordinator: AppCoordinator?
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.windowScene = windowScene
        self.appCoordinator = AppCoordinator(window: window, appDependency: appDependency)
        self.appCoordinator?.start()
        
    }

    

}

