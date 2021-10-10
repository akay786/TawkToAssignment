//
//  TvShowsListService.swift
//  TvShowManager
//
//  Created by Awais on 13/09/2021.
//

import Foundation

protocol UsersService {
    var dataStore: DataStore { get }
    func getUsersList(since: Int, completionHandler: @escaping (Result<[User], NetworkError>) -> Void)
    func getUserProfile(userName: String, completionHandler: @escaping (Result<UserProfile, NetworkError>) -> Void)

}

class UsersServiceImp : UsersService {
    
    var dataStore: DataStore

    init(dataStore : DataStore) {
        self.dataStore = dataStore
    }
    
    func getUsersList(since: Int, completionHandler: @escaping (Result<[User], NetworkError>) -> Void) {
        self.dataStore.getUsersList(since: since) { result in
            completionHandler(result)
        }
    }

    func getUserProfile(userName: String, completionHandler: @escaping (Result<UserProfile, NetworkError>) -> Void) {
        
        self.dataStore.getUserProfile(userName: userName) { result in
            completionHandler(result)
        }
    }
        
}
