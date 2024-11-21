//
//  SignInView.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//



import SwiftUI
import GoogleSignIn



struct SignInView: View {
    @StateObject private var googleSignInVM = GoogleSignInVM()
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if googleSignInVM.isLoggedIn {
                    VStack {
                        Text("Welcome, \(googleSignInVM.givenName)")
                            .font(.title)
                            .padding()
                        
                        if let url = URL(string: googleSignInVM.profilePicUrl) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                } else {
                    Text(googleSignInVM.givenName.isEmpty ? "Not Logged In" : googleSignInVM.givenName)
                        .font(.headline)
                }
                
                Button(action: {
                    googleSignInVM.signIn { success in
                        if success {
                            print("Successfully signed in")
                            print("Given Name: \(googleSignInVM.givenName)")
                            print("Profile Picture URL: \(googleSignInVM.profilePicUrl)")
                        } else {
                            print("Sign-in failed: \(googleSignInVM.errorMessage)")
                        }
                    }
                }) {
                    Text("Sign In with Google")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(8)
                }
                
                if googleSignInVM.isLoggedIn {
                    Button(action: {
                        googleSignInVM.signOut()
                    }) {
                        Text("Sign Out")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            .navigationDestination(isPresented: $googleSignInVM.goToHome) {
                HomeView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

struct Login: View {
    @State private var emailID : String = ""
    @State private var password : String = ""
    @State private var showForgotPassword : Bool = false
    @State private  var showResetView : Bool = false
    @State private var askOTP : Bool = false
    @State private var otpText : String = ""
    @StateObject var vm = UserViewModel()
    @StateObject private var googleSignInVM = GoogleSignInVM()
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15, content: {
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            
            Text("Please sign in to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top,-5)
            
            VStack(spacing : 25 ){
                CustomTF(sfIcon: "person", hint: "Username", value: $emailID)
                CustomTF(sfIcon: "lock", hint: "Password",isPassword :true, value: $password)
                    .padding(.top,5)
                Button("Forgot password?"){
                    showForgotPassword.toggle()
                    
                }.font(.callout)
                    .fontWeight(.heavy)
                    .tint(.blue)
                    .hSpacing(.trailing)
                GradientButton(title: "Login", icon: "arrow.right"){
                   // askOTP.toggle()
                    
                    vm.login(username: emailID, password: password){ success in
                        if success {
                            // Handle successful login
                           // showHome.toggle()
                            navigationViewModel.navigateTo(destination: .Home)
                        } else {
                            // Handle login failure
                            print("Login failed.")
                        }
                    }
                   
                    
                    
                }.hSpacing(.trailing)
                    .disableWidthopacity(emailID.isEmpty || password.isEmpty)
                   
            }
            .padding(.top,20)
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            HStack {
                Spacer()
                Button(action: {
                    googleSignInVM.signIn { success in
                        if success {
                            print("Successfully signed in")
                            print("Given Name: \(googleSignInVM.givenName)")
                            print("Profile Picture URL: \(googleSignInVM.profilePicUrl)")
                            navigationViewModel.navigateTo(destination: .Home)
                        } else {
                            print("Sign-in failed: \(googleSignInVM.errorMessage)")
                        }
                    }
                }) {
                    
                    HStack {
                        Image(.logoGoogle)
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("Sign In with Google")
                            
                    }.font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(8)
                }
                Spacer()
            }
            HStack(spacing:6){
                Text("Don't have account?")
                Button("SignUp"){
                    navigationViewModel.navigateTo(destination: .signUp)
                }.fontWeight(.bold)
                    .tint(.blue)
            }
            .font(.callout)
            .hSpacing()
        })
        .padding(.vertical,15)
        .padding(.horizontal,25)
        // asking email Id to send link
        .sheet(isPresented: $showForgotPassword, content: {
            if #available(iOS 16.4, *){
                ForgotPasswordView(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            }else{
                ForgotPasswordView(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
                    
            }
        })
        // Reset password
        .sheet(isPresented: $showResetView, content: {
            if #available(iOS 16.4, *){
                ResetView()
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            }else{
                ResetView()
                    .presentationDetents([.height(300)])
                    
            }
        })
        .sheet(isPresented: $askOTP, content: {
            if #available(iOS 16.4, *){
                OTPView(otpText: $otpText)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            }else{
                OTPView(otpText: $otpText)
                    .presentationDetents([.height(300)])
                    
            }
        })
        
    }
}


#Preview {
    Login()
        .environmentObject(NavigationViewModel())
}
