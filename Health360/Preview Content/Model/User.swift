//
//  User.swift
//  maladie
//
//  Created by Mohamed Amine Mtar on 20/11/2024.
//

struct User:Hashable, Decodable ,Identifiable {
    let id: String
    let firstname, lastname, username: String
    let  email: String
    let password: String


    
    enum CodingKeys: String, CodingKey {
        case firstname, lastname, username,  email, password
        case id = "_id"
       
    }
}
