//
//  Database.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import Foundation
import CoreData

class Database: NSObject {
    
    static let shared = Database()
    var masterManagedObjectContext: NSManagedObjectContext?
    var managedObjectModel: NSManagedObjectModel?
    var persistentCoordinator: NSPersistentStoreCoordinator?
    
    static let childContext = {
        return Database.shared.newContext()
    }()
    
    func newContext() -> NSManagedObjectContext? {
        guard masterManagedContext() != nil else { return nil }
        let newContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        newContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        newContext.performAndWait {
            newContext.parent = masterManagedObjectContext
        }
        return newContext
    }
    
    func masterManagedContext() -> NSManagedObjectContext? {
        guard masterManagedObjectContext == nil else { return masterManagedObjectContext }
        let coordinator = getCoordinator()
        masterManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        masterManagedObjectContext?.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        masterManagedObjectContext?.performAndWait {
            self.masterManagedObjectContext?.persistentStoreCoordinator = coordinator
        }
        return masterManagedObjectContext
    }
    
    private func getCoordinator() -> NSPersistentStoreCoordinator {
        guard persistentCoordinator == nil else { return persistentCoordinator! }
        persistentCoordinator = NSPersistentStoreCoordinator(managedObjectModel: getObjectModel())
        addPersistance()
        return persistentCoordinator!
    }
    
    private func getObjectModel() -> NSManagedObjectModel {
        guard managedObjectModel == nil else { return managedObjectModel! }
        let objectModelUrl = Bundle.main.url(forResource: "SimpleApp", withExtension: "momd")
        managedObjectModel = NSManagedObjectModel(contentsOf: objectModelUrl!)
        return managedObjectModel!
    }
    
    private func addPersistance() {
        let storeUrl = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last?.appendingPathComponent("SimpleApp").appendingPathExtension("sqlite")
        let options = [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true]
        do {
            let result = try persistentCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: options)
            if (result == nil) { abort() }
        } catch {
            print(error.localizedDescription)
        }
        do {
            try FileManager.default.setAttributes([FileAttributeKey.protectionKey : kCFURLFileProtectionComplete], ofItemAtPath: storeUrl!.path)
        } catch  {
            print(error.localizedDescription)
        }
        
    }
}

extension Database {
    
    static func saveMasterContext() {
        saveChildContext()
        do {
            try Database.shared.masterManagedContext()?.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    static func saveChildContext() {
        do {
            try childContext?.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    static func readData(entity: String, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, fetchLimit: Int?) -> Array<AnyObject> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: childContext!)
        fetchRequest.entity = entityDescription
        if let predicate = predicate { fetchRequest.predicate = predicate }
        if let sortDescriptors = sortDescriptors { fetchRequest.sortDescriptors = sortDescriptors }
        if let fetchLimit = fetchLimit { fetchRequest.fetchLimit = fetchLimit }
        do {
            let result = try childContext?.fetch(fetchRequest)
            return result! as Array<AnyObject>
        } catch  {
            print(error.localizedDescription)
        }
        return []
    }
    
    static func batchDelete(entity: String, predicate: NSPredicate?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: childContext!)
        fetchRequest.entity = entityDescription
        if let predicate = predicate { fetchRequest.predicate = predicate }
        let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try childContext?.persistentStoreCoordinator?.execute(batchDelete, with: childContext!)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    static func deleteObjects(objects: [AnyObject]) {
        objects.forEach { childContext?.delete($0 as! NSManagedObject) }
        saveMasterContext()
    }
    
    static func writeDataTo(entity: String, data: AnyObject) -> NSManagedObject? {
        guard let dataDictionary = data as? [String: Any?] else { return nil }
        guard !dataDictionary.isEmpty else { return nil }
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: entity, into: childContext!)
        for (key, value) in dataDictionary {
            if value is [String: Any?] {
                
            } else if value is Array<Any> {
                
            } else if value != nil {
                insertData(into: newEntity, key: key, value: value!)
            }
        }
        return newEntity
    }
    
    private static func insertData(into entity: NSManagedObject, key: String, value: Any) {
        guard let attributeDescription = entity.entity.propertiesByName[key] as? NSAttributeDescription
        else { return }
        entity.setValue(getDecodedData(value: value, attributeDescription: attributeDescription), forKey: key)
    }
    
    private static func setParentChildAssociation(childEntity: NSManagedObject, parentEntity: NSManagedObject, key: String) {
        parentEntity.setValue(childEntity, forKey: key)
    }
    
    private static func getDecodedData(value: Any, attributeDescription: NSAttributeDescription) -> Any {
        if value is NSNull {
            return NSNull()
        }
        if value is String && (value as? String)?.count == 0 {
            return NSNull()
        }
        if attributeDescription.attributeType == NSAttributeType.doubleAttributeType || attributeDescription.attributeType == NSAttributeType.floatAttributeType || attributeDescription.attributeType == NSAttributeType.decimalAttributeType {
            return NSDecimalNumber(string: Common.shared.roundOffTo(digits: 2, value: value))
        }
        return value
    }
}
