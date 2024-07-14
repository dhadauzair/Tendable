//
//  Utility.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import Foundation

final class Utility {
    
    //MARK: - Variables -
    
    // Variables
    static let sharedInstance = Utility() // singleton instance
        
    let defaults = UserDefaults.standard // user defaults instance
    
    //MARK: - User Defaults Methods -
    
    /// Store any value to user defaults
    ///
    /// - Parameters:
    ///   - value: value to be stored
    ///   - forKey: identifier key for value
    private func saveValueToUserDefaultsWith(value:Any, forKey key:String) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    /// Access any value stored from user defaults
    ///
    ///   - value: value to be stored
    ///   - forKey: identifier key for value
    private func getValueFromNSUserdefaults(forKey:String) -> AnyObject {
        return defaults.value(forKey: forKey) as AnyObject
    }
    
    func saveLoggedInUser(emailId : String) {
        Utility.sharedInstance.saveValueToUserDefaultsWith(value: emailId, forKey: Constants.Keys.emailId)
    }
    
    func getLoggedInUser() -> String {
        return Utility.sharedInstance.getValueFromNSUserdefaults(forKey: Constants.Keys.emailId) as? String ?? ""
    }
    
}
