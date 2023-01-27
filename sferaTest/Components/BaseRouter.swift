//
//  BaseRouter.swift
//  sferaTest
//
//  Created by Иван on 14.12.22.
//

import UIKit

class BaseRouter {
    var navigationControllerProvider: (() -> UINavigationController?)?
    var moduleDependencies: AppDependency?
    
    var navigationController: UINavigationController? {
        self.navigationControllerProvider?()
    }
}
 
