//
//  UIViewControllerExtensions.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import Foundation
import UIKit

extension UIViewController {
    static var identifier: String
    {
        return String(describing: self)
    }
}
