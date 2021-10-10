//
//  CoreDataMock.swift
//  TawkToAssignmentTests
//
//  Created by VenD on 11/10/2021.
//

import Foundation
import CoreData
import XCTest


class CoreDataMock {
    
    init() { }
    
    lazy var mockManagedObjectModel: NSManagedObjectModel = {
            let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
            return managedObjectModel
    }()

    lazy var mockPersistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataCodable", managedObjectModel: mockManagedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition(description.type == NSInMemoryStoreType)
            if let error = error {
                XCTFail("Error creating the in-memory NSPersistentContainer mock: \(error)")
            }
        }
        
        return container
    }()
    
}
