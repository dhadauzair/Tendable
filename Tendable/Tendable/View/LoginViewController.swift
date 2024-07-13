//
//  LoginViewController.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/13/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let viewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didSelectLoginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
//        viewModel.login(email: "test@test.com", password: "test") { [weak self] result in
        viewModel.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let inspectionViewController = storyBoard.instantiateViewController(withIdentifier: InspectionViewController.identifier) as! InspectionViewController
                    self?.navigationController?.pushViewController(inspectionViewController, animated: true)
                    print("Success")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
