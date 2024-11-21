//
//  SignUpView.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//

import SwiftUI

struct SignUp: View {
    @State private var emailID : String = ""
    @State private var firstName : String = ""
    @State private var lastName : String = ""
    @State private var userName : String = ""
    @State private var confirmpass_signup : String = ""
    @State private var password : String = ""
    @State private var askOTP : Bool = false
    @State private var otpText : String = ""
    @StateObject var vm = UserViewModel()
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button(action: {
                //showSignup = false
                navigationViewModel.navigateBack()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top,10)
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Text("SignUp")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            
            Text("Please sign up to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top,-5)
            
            VStack(spacing : 25 ){
                CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)
                CustomTF(sfIcon: "person", hint: "First Name", value: $firstName)
                CustomTF(sfIcon: "person", hint: "Last Name", value: $lastName)
                CustomTF(sfIcon: "person", hint: "UserName", value: $userName)
                CustomTF(sfIcon: "lock", hint: "Password",isPassword :true, value: $password)
                    .padding(.top,5)
                CustomTF(sfIcon: "lock", hint: "Confirm Password",isPassword :true, value: $confirmpass_signup)
                    .padding(.top,5)
                
                GradientButton(title: "Continue", icon: "arrow.right"){
                        vm.signup(email: emailID, password: password, firstname: firstName, lastname: lastName, username: userName, confirmpass_singup: confirmpass_signup) { success in
                            if success {
                                AppStorageManager.shared.firstname = firstName
                                AppStorageManager.shared.lastname = lastName
                                AppStorageManager.shared.email = emailID
                               
                                
                                navigationViewModel.navigateTo(destination: .Home)
                                print("Signup successful.")
                            } else {
                                // Handle signup failure
                                print("Signup failed.")
                            }
                        }
                    //askOTP.toggle()
                }.hSpacing(.trailing)
                    .disableWidthopacity(emailID.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty || userName.isEmpty || confirmpass_signup.isEmpty )
            }
            .padding(.top,20)
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            HStack(spacing:6){
                Text("Already have an account?")
                Button("Login"){
                  //  showSignup = false
                    navigationViewModel.navigateBack()
                }.fontWeight(.bold)
                    .tint(.cyan)
            }
            .font(.callout)
            .hSpacing()
        })
        .padding(.vertical,15)
        .padding(.horizontal,25)
        .toolbar(.hidden, for: .navigationBar)
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
    SignUp()
}
