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
        
        if !Utility.sharedInstance.getLoggedInUser().isEmpty {
            showHomeView()
        }
    }
    
    func showHomeView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: HomeViewController.identifier) as! HomeViewController
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    func isEmailValid(emailId: String) -> Bool {
        return emailId.isValidEmail()
    }
    
    func isPasswordValid(password: String) -> Bool {
        return !password.isEmpty
    }
    
    func userLoginOrRegistrationFailed(errorCode: Int, WithEndpoint endpoint: EndpointService) -> Bool {
        var isFailure = false
        switch errorCode {
        case 400:
            self.showAlert(title: "Error", message: "email or password fields are missing", actionTitle: Constants.CommonLocalisations.okTitle)
            isFailure = true
        case 401:
            switch endpoint {
            case .loginUser:
                self.showAlert(title: "Error", message: "user does not exist or the credentials are incorrect", actionTitle: Constants.CommonLocalisations.okTitle)
                isFailure = true
            case .register:
                self.showAlert(title: "Error", message: "user already exists", actionTitle: Constants.CommonLocalisations.okTitle)
            default:
                break
            }
        default:
            break
        }
        return isFailure
    }
    
    @IBAction func didSelectLoginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, isEmailValid(emailId: email), isPasswordValid(password: password) else { return }
        viewModel.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    Utility.sharedInstance.saveLoggedInUser(emailId: self?.emailTextField.text ?? "")
                    CoreDataService.sharedInstance.saveUserEntity(userMailId: self?.emailTextField.text ?? "")
                    self?.showAlert(title:Constants.CommonLocalisations.appNameTitle, message: Constants.CommonLocalisations.loginSuccessTitle, actionTitle: nil) {
                        self?.showHomeView()
                    }
                case .failure(let error):
                    _ = self?.userLoginOrRegistrationFailed(errorCode: error.errorCode,WithEndpoint: .loginUser)
                }
            }
        }
    }
    
    @IBAction func didSelectRegisterButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, isEmailValid(emailId: email), isPasswordValid(password: password) else { return }
        viewModel.register(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.showAlert(title:Constants.CommonLocalisations.appNameTitle, message: Constants.CommonLocalisations.registerSuccessTitle, actionTitle: nil) {
                        self?.emailTextField.text = ""
                        self?.passwordTextField.text = ""
                    }
                    print("Success")
                case .failure(let error):
                    _ = self?.userLoginOrRegistrationFailed(errorCode: error.errorCode, WithEndpoint: .register)
                }
            }
        }
    }
    
}
