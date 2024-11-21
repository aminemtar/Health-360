//
//  GoogleSignInVM.swift
//  maladie
//
//  Created by Mohamed Amine Mtar on 20/11/2024.
//
import SwiftUI
import GoogleSignIn

class GoogleSignInVM: ObservableObject {
    @Published var givenName: String = ""
    @Published var mail: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    
    @Published var profilePicUrl: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var goToHome: Bool = false
    init(){
        check()
    }
    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil){
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            let givenName = user.profile?.name
            let mail = user.profile?.email
            let familyName = user.profile?.givenName
            let fullName = user.profile?.familyName
            let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
            self.givenName = givenName ?? ""
            self.firstName = fullName ?? ""
            self.lastName = familyName ?? ""
            self.mail = mail ?? ""
            self.profilePicUrl = profilePicUrl
            self.isLoggedIn = true
        }else{
            self.isLoggedIn = false
            self.givenName = "Not Logged In"
            self.profilePicUrl =  ""
        }
    }
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            
            self.checkStatus()
        }
    }
    func signIn( completed: @escaping (Bool) -> Void){
        
       guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

        
        GIDSignIn.sharedInstance.signIn(
            withPresenting: presentingViewController){ signInResult, error in
            guard error == nil else { return }
               guard let signInResult = signInResult else { return }

               let user = signInResult.user

               let emailAddress = user.profile?.email

               let fullName = user.profile?.name
               let givenName = user.profile?.givenName
               let familyName = user.profile?.familyName

                print(fullName ?? "no")
                self.goToHome = true
            
        }
    }
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
}
