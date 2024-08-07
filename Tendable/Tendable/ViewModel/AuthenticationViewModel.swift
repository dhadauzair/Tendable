//
//  AuthenticationViewModel.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/13/24.
//

import Foundation

class AuthenticationViewModel {
    
    func login(email: String, password: String, completion: @escaping (Result<BoolResponse, Error>) -> Void) {
        let user = User(email: email, password: password)
        guard let dictionaryValues = user.dictionary else {
            print("Unable to convert User to Dictionary in AuthenticationViewModel: login")
            return
        }
        APIBaseService.shared.request(.loginUser, body: dictionaryValues, completion: completion)
    }
    
    func register(email: String, password: String, completion: @escaping (Result<BoolResponse, Error>) -> Void) {
        let user = User(email: email, password: password)
        guard let dictionaryValues = user.dictionary else {
            print("Unable to convert User to Dictionary in AuthenticationViewModel: Register")
            return
        }
        APIBaseService.shared.request(.register, body: dictionaryValues, completion: completion)
    }
}

