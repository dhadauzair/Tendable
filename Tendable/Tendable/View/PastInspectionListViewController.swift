//
//  PastInspectionListViewController.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/15/24.
//

import UIKit

class PastInspectionListViewController: UIViewController {

    let viewModel = PastInspectionListViewModel()
    @IBOutlet weak var pastInspectionListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        getPastInspections()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
