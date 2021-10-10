//
//  TvShowsListService.swift
//  TvShowManager
//
//  Created by Awais on 13/09/2021.
//

import Foundation
import CoreData

protocol UsersService {
    var dataStore: DataStore { get }
    var persistentContainer: NSPersistentContainer { get }
    
    func getUsersList(since: Int, completionHandler: @escaping (Result<[User], NetworkError>) -> Void)
    func getUserProfile(userName: String, completionHandler: @escaping (Result<UserProfile, NetworkError>) -> Void)
    
    
    func fetchLocalUserList(completionHandler: @escaping (_ users: [User]?) -> Void)
    func saveInDatabase(jsonData: Data, completion: @escaping(_ users: [User]?) -> ())
}

class UsersServiceImp : UsersService {
    
    
    var dataStore: DataStore
    var persistentContainer: NSPersistentContainer
    
    init(dataStore : DataStore, persistentContainer: NSPersistentContainer) {
        self.dataStore = dataStore
        self.persistentContainer = persistentContainer
    }
    
    
    //MARK: - Private Methods
    func getUsersList(since: Int, completionHandler: @escaping (Result<[User], NetworkError>) -> Void) {
        self.dataStore.getUsersList(since: since, persistentContainer: self.persistentContainer) { result in
            
            switch result {
                case.success(let data):
                    self.saveInDatabase(jsonData: data) { users in
                        completionHandler(.success(users ?? []))
                    }
                    
                case .failure(let error):
                    completionHandler(.failure(error))
            }
        }
    }

    func getUserProfile(userName: String, completionHandler: @escaping (Result<UserProfile, NetworkError>) -> Void) {
        self.dataStore.getUserProfile(userName: userName) { result in
            completionHandler(result)
        }
    }
      
    
    //MARK: - Local Database Helper Functions
    func fetchLocalUserList(completionHandler: @escaping ([User]?) -> Void) {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            completionHandler(users)
        } catch _ {
            completionHandler([])
        }
    }
    
    func saveInDatabase(jsonData: Data, completion: @escaping ([User]?) -> ()) {
        do {
            if let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext {
                let managedObjectContext = persistentContainer.viewContext
                let decoder = JSONDecoder()
                decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                let users = try decoder.decode([User].self, from: jsonData)
                try managedObjectContext.save()
                completion(users)
            }
            
        } catch let error {
            print(error)
        }
    }
}
