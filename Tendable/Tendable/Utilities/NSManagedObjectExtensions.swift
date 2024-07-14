//
//  NSManagedObjectExtensions.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import Foundation
import CoreData

extension NSManagedObject {
    static var identifier: String {
        return String(describing: self)
    }
}
