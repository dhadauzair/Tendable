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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func didSelectLogoutButton(_ sender: Any) {
        Utility.sharedInstance.deleteLoggedInCustomer()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didSelectNewInspectionButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let inspectionViewController = storyBoard.instantiateViewController(withIdentifier: InspectionViewController.identifier) as! InspectionViewController
        self.navigationController?.pushViewController(inspectionViewController, animated: true)
    }
    
    @IBAction func didSelectPastInspectionButton(_ sender: Any) {
//        let pastInspectionsEntity = CoreDataService.sharedInstance.getInspectionsEntity(Utility.sharedInstance.getLoggedInUser())
//        guard let pastInspectionsEntity = pastInspectionsEntity else { return }
//        let pastSavedInspection = CoreDataService.sharedInstance.getAllSavedInspections(inspectionEntity: pastInspectionsEntity)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let pastInspectionListViewController = storyBoard.instantiateViewController(withIdentifier: PastInspectionListViewController.identifier) as! PastInspectionListViewController
        pastInspectionListViewController.pastSavedInspections = pastInspectionListViewController.viewModel.getPastInspectionsLocally()
        self.navigationController?.pushViewController(pastInspectionListViewController, animated: true)
    }
}
