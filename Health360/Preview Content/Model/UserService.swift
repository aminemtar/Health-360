//
//  UserService.swift
//  maladie
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//

import Foundation

@Observable
class UserService{
    
    
    func signup(email: String, password: String,firstname:String,lastname:String,username:String,confirmpass_singup:String, completion: @escaping (Result<SignupResponse, NetworkError>) -> Void) {
           
        guard let url = URL(string: "http://localhost:3000/auth/signup") else {
            completion(.failure(.badUrl))
               return
           }
           
        let body = SignupRequest(email: email, password: password, firstname: firstname, lastname: lastname, username: username, confirmpass_singup: confirmpass_singup)
        print(body)
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.httpBody = try? JSONEncoder().encode(body)
           
           URLSession.shared.dataTask(with: request) { (data, response, error) in
               
               guard let data = data, error == nil else {
                   completion(.failure(.badResponse))
                   return
               }
               guard let user = try? JSONDecoder().decode(SignupResponse.self, from: data) else {
                       completion(.failure(.failedToDecodeResponse))
                   return
               }
            
               completion(.success(user))
               
           }.resume()
           
       }
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
           
        guard let url = URL(string: "http://localhost:3000/auth/login") else {
            completion(.failure(.badUrl))
               return
           }
           
        let body = LoginRequest(username: username, password: password)
        print(body)
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.httpBody = try? JSONEncoder().encode(body)
           
           URLSession.shared.dataTask(with: request) { (data, response, error) in
               
               guard let data = data, error == nil else {
                   completion(.failure(.badResponse))
                   return
               }
               guard let user = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                       completion(.failure(.failedToDecodeResponse))
                   return
               }
            
               completion(.success(user))
               
           }.resume()
           
       }
    func sendResetMail(email_FP: String, completion: @escaping (Result<Int, NetworkError>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/auth/forgot-password") else {
            completion(.failure(.badUrl))
            return
        }

        let body = ResetMailRequest(email_FP: email_FP)
        print(body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.badResponse))
                return
            }
            
            // Decode the plain integer response (assuming it's the reset code)
            if let resetCode = Int(String(data: data, encoding: .utf8) ?? "") {
                completion(.success(resetCode))
            } else {
                completion(.failure(.failedToDecodeResponse))
            }
        }.resume()
    }
    
}
struct LoginRequest: Encodable {
    let username: String
    let password: String
}
struct ResetMailRequest: Encodable {
    let email_FP: String
}
struct SignupRequest: Encodable {
    let email: String
    let password: String
    let firstname: String
    let lastname:String
    let username:String
    let confirmpass_singup:String
}
enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}
struct LoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    let userId: String?
}
struct SignupResponse: Decodable {
    let id:String
    let email: String
    let password: String
    let firstname: String
    let lastname:String
    let username:String
    enum CodingKeys: String, CodingKey {
            case id = "_id"
            case email
            case password
            case firstname
            case lastname
            case username
        }
}
