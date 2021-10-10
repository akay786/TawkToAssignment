//
//  UserListCoordinator.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import UIKit

class UserListCoordinator: Coordinator {
    
    private var rootViewController: UINavigationController!
    //private var addTvShowCoordinator : AddTvShowCoordinator!
    private var dataStore : DataStore
    
    
    //MARK: - Initializer
    init( dataStore : DataStore) {
        self.dataStore = dataStore
    }
    
    func start() -> UIViewController {
        if let usersListVC = UserListCoordinator.instantiateViewController() as? UsersListViewController {
            rootViewController = BaseNavigationController(rootViewController: usersListVC)
            
            let service = UsersServiceImp(dataStore: self.dataStore)
            let viewModel = UsersListViewModelImp(users: [], service: service)
            viewModel.coordinatorDelegate = self
            usersListVC.viewModel = viewModel
            return rootViewController
        }
        
        return UIViewController()
    }
}


//MARK: - TvShowsList Coordinator Delegate
extension UserListCoordinator : UsersListViewModelCoordinatorDelegate{
    
    /// This function called when user tapped on add new tv show button on listing screen
    func didTapOnUser(user: User, delegate: UsersListViewModelImp) {
        
        let userProfileCoordinator = UserProfileCoordinator(navigationController: self.rootViewController,
                                                    dataStore: self.dataStore,
                                                    user: user)
        if let userProfileVC = userProfileCoordinator.start() as? UserProfileViewController {
            //userProfileVC.viewModel.delegate = delegate
            self.rootViewController.pushViewController(userProfileVC, animated: true)
        }
    }
    
}


//MARK: - StoryboardInitializable
extension UserListCoordinator: StoryboardInitializable {
    
    static var storyboardName: UIStoryboard.Storyboard {
        return .main
    }
    
}
