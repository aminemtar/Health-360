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
                    
                    Text("\(googleSignInVM.givenName)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(googleSignInVM.mail)")
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
                    ProfileRow(title: "First Name", value: googleSignInVM.firstName)
                    ProfileRow(title: "Last Name", value: googleSignInVM.lastName)
                    ProfileRow(title: "Mail", value: googleSignInVM.mail)
                    ProfileRow(title: "Age", value: "\(age)")
                    Button(action: {
                        googleSignInVM.signOut()
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
            
           
        }
    
}
#Preview {
    ProfilePage()
}
