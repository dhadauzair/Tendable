//
//  InspectionViewController.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import UIKit

class InspectionViewController: UIViewController {

    @IBOutlet weak var inspectionTableView: UITableView!
    
    var viewModel = InspectionViewModel()
    var inspection: Inspection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startNewInspection()
    }
    
    func startNewInspection() {
        viewModel.startNewInspection { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let inspectionModel):
                    self?.inspection = inspectionModel.inspection
                    self?.inspectionTableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension InspectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return inspection?.survey?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inspectionCategory = inspection?.survey?.categories?[section]
        return inspectionCategory?.questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InspectionQATableViewCell.identifier, for: indexPath) as? InspectionQATableViewCell else {
            return UITableViewCell()
        }
        let inspectionCategory = inspection?.survey?.categories?[indexPath.section]
        let question = inspectionCategory?.questions?[indexPath.row]

        cell.configureCell(question: question?.name ?? "", answers: question?.answerChoices)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return inspection?.survey?.categories?[section].name
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
