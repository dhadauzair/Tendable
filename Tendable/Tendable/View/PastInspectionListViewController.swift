//
//  PastInspectionListViewController.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/15/24.
//

import UIKit

class PastInspectionListViewController: UIViewController {

    let viewModel = PastInspectionListViewModel()
    var pastSavedInspections =  [Inspection]()
    
    @IBOutlet weak var pastInspectionListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
//        getPastInspections()
    }
    
    func getPastInspections() {
        viewModel.getPastInspections { result in
            switch result {
            case .success(_):
                print("")
            case .failure(_):
                print("")
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PastInspectionListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastSavedInspections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PastInspectionListTableViewCell.identifier, for: indexPath) as? PastInspectionListTableViewCell else {
            return UITableViewCell()
        }
        guard let areaName = pastSavedInspections[indexPath.row].area?.name, let inspectionId = pastSavedInspections[indexPath.row].id else {
            return cell
        }
        cell.configureCell(inspectionAreaName: "Area Name: " + areaName + " Inspection ID:" + " \(inspectionId)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
