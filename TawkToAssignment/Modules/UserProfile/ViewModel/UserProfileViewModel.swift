//
//  UserProfileViewModel.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import Foundation

typealias UserProfileViewModelOutputHandler = (UserProfileViewModelOutput) -> ()

//protocol UsersListViewModelCoordinatorDelegate : class {
//    func didTapOnUser(user: User, delegate: UsersListViewModelImp)
//}

protocol UserProfileViewModel {
    
    var service : UsersService { get }
    var userProfile: UserProfile? { get set }
    var title: String { get }
    var completionHandler: UserProfileViewModelOutputHandler? { get set }
    
    func fetchUserDetail()
}

enum UserProfileViewModelOutput {
    case showLoader
    case hideLoader
    case updateProfile
}