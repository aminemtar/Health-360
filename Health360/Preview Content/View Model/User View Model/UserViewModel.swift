//
//  UserViewModel.swift
//  maladie
//
//  Created by Mohamed Amine Mtar on 20/11/2024.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user : User?
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var username: String = ""
    @Published var confirmpass_singup: String = ""
    @Published var loginError: Error?
    @Published var isAuthenticated: Bool = false
    
    
    func signup(email: String, password: String,firstname:String,lastname:String,username:String,confirmpass_singup:String,completion: @escaping (Bool) -> Void) {
        print(username)
        UserService().signup(email: email, password: password, firstname: firstname, lastname: lastname, username: username, confirmpass_singup: confirmpass_singup){ result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                   // self.user = user
                    print(user)
                    completion(true)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    func login(username: String, password: String,completion: @escaping (Bool) -> Void) {
        print(username)
        UserService().login(username: username, password: password){ result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                   // self.user = user
                    print(user)
                    completion(true)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    func ResetMail(email_FP: String,completion: @escaping (Bool) -> Void) {
        print(username)
        UserService().sendResetMail(email_FP: email_FP){ result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                   // self.user = user
                    print(user)
                    completion(true)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
}
