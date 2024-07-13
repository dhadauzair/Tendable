//
//  InspectionViewController.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import UIKit

class InspectionViewController: UIViewController {

    var viewModel = InspectionViewModel()
    
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
                case .success(let inspection):
                    print(inspection)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
