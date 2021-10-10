//
//  AppCoordinator.swift
//  TawkToAssignment
//
//  Created by VenD on 05/10/2021.
//

import Foundation
import UIKit

protocol Coordinator {
    func start() -> UIViewController
}


final class AppCoordinator: Coordinator {
    
    lazy var dataStore : DataStore = {
        return DataStoreImp()
    }()
    
    private var window : UIWindow?

    var userListCoordinator: UserListCoordinator?
    

    //MARK: - Initializer
    init(window : UIWindow?) {
        self.window = window
    }
    
    
    @discardableResult
    func start() -> UIViewController {
        userListCoordinator = UserListCoordinator(dataStore: self.dataStore)
        let mainVC = userListCoordinator?.start()
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        return UIViewController()
    }
}
