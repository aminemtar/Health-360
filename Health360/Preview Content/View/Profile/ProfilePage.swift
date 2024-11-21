//
//  ProfilePage.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//

import SwiftUI

struct ProfilePage: View {
    var nom = "Oumayma"
    var prenom = "Zliaa"
    var mail = "Oumayma.Zliaa@esprit.tn"
    var age = 30
    @State private var showPasswordChangeSheet = false
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @StateObject private var googleSignInVM = GoogleSignInVM()
    @State private var navigateToSignInView = false
    
    var body: some View {
            VStack(spacing: 20) {
                
                VStack {
                    if let url = URL(string: googleSignInVM.profilePicUrl) {
                                       AsyncImage(url: url) { image in
                                           image
                                               .resizable()
                                               .scaledToFit()
                                               .frame(width: 120, height: 120)
                                               .clipShape(Circle())
                                       } placeholder: {
                                           ProgressView()
                                       }
                   
                                   } else {
                                       Image(systemName: "person.crop.circle.fill")
                                           .resizable()
                                           .frame(width: 120, height: 120)
                                           .foregroundColor(.purple)
                                           .padding()
                                   }
                    
                    Text("\(AppStorageManager.shared.firstname ?? googleSignInVM.givenName)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(AppStorageManager.shared.email  ?? googleSignInVM.mail)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)
                
                VStack(spacing: 15) {
                    ProfileRow(title: "First Name", value:  AppStorageManager.shared.firstname ?? googleSignInVM.firstName)
                    ProfileRow(title: "Last Name", value:AppStorageManager.shared.lastname ?? googleSignInVM.lastName)
                    ProfileRow(title: "Mail", value:AppStorageManager.shared.email ?? googleSignInVM.mail)
                    ProfileRow(title: "Password", value: "••••••••")
                        .onTapGesture {
                                                showPasswordChangeSheet.toggle()
                                            }
                    Button(action: {
                        googleSignInVM.signOut()
                        AppStorageManager.shared.clearToken()
                        navigationViewModel.navigateTo(destination: .SignIn)
           
                    }) {
                        Text("Sign Out")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)
                
               
                Spacer()
                
            }
           .padding(.top, 20)
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $showPasswordChangeSheet, content: {
                if #available(iOS 16.4, *){
                    ChangePasswordView()
                        .presentationDetents([.height(300)])
                        .presentationCornerRadius(30)
                }else{
                    ChangePasswordView()
                        .presentationDetents([.height(300)])
                        
                }
            })
            
           
        }
    
}
#Preview {
    ProfilePage()
}
