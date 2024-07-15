//
//  PastInspectionListViewController.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/15/24.
//

import UIKit

enum InspectionListSections: Int {
    case Draft, Submitted
    
    var string: String {
        return String(describing: self)
    }
}

class PastInspectionListViewController: UIViewController {

    let viewModel = PastInspectionListViewModel()
    var pastSavedInspections =  [Inspection]()
    var draftInspection = [Inspection]()
    var submittedInspection = [Inspection]()
//    var upcomingInspections = [Inspection]()
    
    @IBOutlet weak var pastInspectionListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOnViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setUpOnViewDidLoad() {
        draftInspection = pastSavedInspections.filter({ $0.isSubmitted == false })
        submittedInspection = pastSavedInspections.filter({ $0.isSubmitted == true })
//        getUpcomingInspections()
    }
    
    func showInspectionView(_ inspection: Inspection) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let inspectionViewController = storyBoard.instantiateViewController(withIdentifier: InspectionViewController.identifier) as! InspectionViewController
        inspectionViewController.inspection = inspection
        inspectionViewController.isFromPastInspection = true
        self.navigationController?.pushViewController(inspectionViewController, animated: true)
    }
    
//    func getUpcomingInspections() {
//        viewModel.getUpComingInspections { result in
//            switch result {
//            case .success(let inspections):
//                upcomingInspections = inspections
//            case .failure(_):
//                print("")
//            }
//        }
//    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PastInspectionListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var sections = 0
        if !draftInspection.isEmpty {
            sections += 1
        }
        
        if !submittedInspection.isEmpty {
            sections += 1
        }
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == InspectionListSections.Draft.rawValue {
            return draftInspection.count
        } else if section == InspectionListSections.Submitted.rawValue {
            return submittedInspection.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PastInspectionListTableViewCell.identifier, for: indexPath) as? PastInspectionListTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.section == InspectionListSections.Draft.rawValue {
            cell.configureCell(inspection: draftInspection[indexPath.row])
        } else {
            cell.configureCell(inspection: submittedInspection[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == InspectionListSections.Draft.rawValue {
            return InspectionListSections.Draft.string
        } else {
            return InspectionListSections.Submitted.string
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == InspectionListSections.Draft.rawValue {
            showInspectionView(draftInspection[indexPath.row])
        } else {
            showInspectionView(submittedInspection[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
