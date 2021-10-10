//
//  DataStoreMock.swift
//  TawkToAssignmentTests
//
//  Created by VenD on 11/10/2021.
//

import Foundation
@testable import TawkToAssignment



class DataStorePositiveMock: DataStore {
    
    func getUserProfile(userName: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        completionHandler(.success(userProfileResponse))
    }
    
    func getUsersList(since: Int, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        completionHandler(.success(userListResponse))
    }
    
}


class DataStoreNegativeMock: DataStore {
    
    func getUserProfile(userName: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let error = NetworkError.init(rawValue: "User does not exist") else {
            return
        }
        completionHandler(.failure(error))
    }
    
    func getUsersList(since: Int, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let error = NetworkError.init(rawValue: "Parsing error") else {
            return
        }
        completionHandler(.failure(error))
    }
    
}
