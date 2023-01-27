//
//  AppDependency.swift
//  sferaTest
//
//  Created by Иван on 12/7/22.
//

import Foundation


protocol HasDependencies {
    var networkService: NetworkServiceProtocol { get }
    var cdStack: CDStackProtocol { get }
}

class AppDependency {
    let appNetworkService: NetworkService
    let cd: CDStack
    
    init(networkService: NetworkService, cd: CDStack) {
        self.appNetworkService = networkService
        self.cd = cd
    }
    
    static func makeDefault() -> AppDependency {
        let networkService = NetworkService()
        let cd = CDStack()
        return AppDependency(networkService: networkService, cd: cd)
    }
}

extension AppDependency: HasDependencies {
    var networkService: NetworkServiceProtocol {
        return self.appNetworkService
    }
    var cdStack: CDStackProtocol {
        return self.cd
    }
}
    



