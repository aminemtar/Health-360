//
//  AppStorageManager.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//

import Foundation
import SwiftUI

struct AppStorageManager
{
    static let shared  = AppStorageManager()
    
    @AppStorage("login") var login:Bool = false
    @AppStorage("firstname") var firstname: String?
    @AppStorage("lastname") var lastname: String?
    @AppStorage("firstname") var email: String?
    @AppStorage("userId") var userId: String?
  
    func clearToken() {
        login = false
        firstname = nil
        lastname = nil
        email = nil
        userId = nil
        }
}
