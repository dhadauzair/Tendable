//
//  TendableUserEntity+CoreDataProperties.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//
//

import Foundation
import CoreData


extension TendableUserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TendableUserEntity> {
        return NSFetchRequest<TendableUserEntity>(entityName: "TendableUserEntity")
    }

    @NSManaged public var email: String?

}

extension TendableUserEntity : Identifiable {

}
