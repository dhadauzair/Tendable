//
//  UIViewControllerExtensions.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import Foundation
import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    func showAlert(title: String, message: String, actionTitle: String?, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actionTitle?.isEmpty != nil {
            let okAction = UIAlertAction(title: actionTitle, style: .default) { _ in
                completion?()
            }
            alertController.addAction(okAction)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                alertController.dismiss(animated: true) {
                    completion?()
                }
            })
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
