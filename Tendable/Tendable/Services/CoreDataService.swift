//
//  CoreDataService.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import Foundation
import CoreData
import UIKit

final class CoreDataService: NSObject {
    
    static let sharedInstance = CoreDataService()
    
    private override init() { }
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveUserEntity(userMailId: String) {
        let newUser = TendableUserEntity(context: context)
        newUser.email = userMailId
        
        do {
            try context.save()
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func getUserEntity(_ userMailId: String) -> TendableUserEntity? {
        let fetchRequest = NSFetchRequest<TendableUserEntity>(entityName: TendableUserEntity.identifier)
        // Create and set the predicate
        let predicate = NSPredicate(format: "email == %@", userMailId)
        fetchRequest.predicate = predicate
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.first
        } catch {
            print("Failed fetching: \(error)")
        }
        return nil
    }
}
