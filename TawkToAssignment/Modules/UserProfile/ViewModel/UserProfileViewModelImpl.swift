//
//  UserProfileViewModelImpl.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import Foundation

class UserProfileViewModelImpl: UserProfileViewModel {
    
    var userProfile: UserProfile?
    private var user: User
    
    
    var service: UsersService
    
    
    var completionHandler: UserProfileViewModelOutputHandler?
    
    
    //MARK: - Initializer
    init(user: User, service: UsersService) {
        self.service = service
        self.user = user
        self.fetchUserDetail()
    }
    
    
    //MARK: - Computed Properties
    var title: String {
        return AppConstants.Constants.profile
    }
    
    
    //MARK: - Helper Methods
    func fetchUserDetail() {
        self.getUserProfile()
    }
    
}


//MARK: - Api Call
extension UserProfileViewModelImpl {
    
    private func getUserProfile() {
        completionHandler?(.showLoader)
        self.service.getUserProfile(userName: self.user.login ?? "") { [weak self] result in
            
            self?.completionHandler?(.hideLoader)
            
            switch result {
            
            case .success(let profile):
                self?.userProfile = profile
                self?.completionHandler?(.updateProfile)
                
            case .failure(let error):
                break
            }
        }
    }
}

