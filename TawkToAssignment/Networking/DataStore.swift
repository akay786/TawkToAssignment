//
//  DataStore.swift
//  TvShowManager
//
//  Created by Awais on 13/09/2021.
//

import Foundation

enum NetworkError: String, Error {
    case serverError = "Server Error"
    case parsinError = "Unable to parse json from server"
}

protocol DataStore {
    func getUsersList(since: Int, completionHandler: @escaping (Result<[User], NetworkError>) -> Void)
    func getUserProfile(userName: String, completionHandler: @escaping (Result<UserProfile, NetworkError>) -> Void)
}

class DataStoreImp: DataStore {
    
    func getUserProfile(userName: String, completionHandler: @escaping (Result<UserProfile, NetworkError>) -> Void) {
        
        let urlString = String.init(format: "%@%@", AppConstants.EndPoints.getUserProfile,userName)
        
        guard let url = URL(string: urlString)  else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard let data = data else {
                completionHandler(.failure(.serverError))
                return
            }
            
            do {
                
                let userProfile = try JSONDecoder().decode(UserProfile.self, from: data)
                completionHandler(.success(userProfile))
                
                
            } catch let error {
                dump(error)
                completionHandler(.failure(.parsinError))
            }
        })
        task.resume()
        
    }
    
    
    /// This function returns users list from server.
    ///
    /// - Returns: A saved tv object array if successfully fetched and error object if failed
    func getUsersList(since: Int, completionHandler: @escaping (Result<[User], NetworkError>) -> Void) {
        
        let urlComponents = NSURLComponents(string: AppConstants.EndPoints.getAllUsers)
        urlComponents?.queryItems = [
            URLQueryItem(name: "since", value: String(since))
        ]
        
        guard let url = urlComponents?.url  else {
            return
        }
        

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard let data = data else {
                completionHandler(.failure(.serverError))
                return
            }
            
            do {
                
                let usersList = try JSONDecoder().decode([User].self, from: data)
                completionHandler(.success(usersList))
                
                
            } catch _ {
                completionHandler(.failure(.parsinError))
            }
        })
        task.resume()
    }
    
}
