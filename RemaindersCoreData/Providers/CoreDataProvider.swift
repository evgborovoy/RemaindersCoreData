//
//  CoreDataProvider.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/12/24.
//

import Foundation
import CoreData

class CoreDataProvider {
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "RemaindersModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Failed to load RemaindersModel: \(error)")
            }
        }
    }
}
