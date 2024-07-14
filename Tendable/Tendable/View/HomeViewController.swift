//
//  HomeViewController.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomUserLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomUserLabel.text = "Welcome \(Utility.sharedInstance.getLoggedInUser())"
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func didSelectLogoutButton(_ sender: Any) {
        Utility.sharedInstance.deleteLoggedInCustomer()
        self.navigationController?.popViewController(animated: true)
    }
}
