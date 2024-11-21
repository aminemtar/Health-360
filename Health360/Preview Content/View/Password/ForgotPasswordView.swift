//
//  ForgotPasswordView.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//

import SwiftUI



struct ForgotPasswordView: View {
    @State private var emailID : String = ""
    @Binding  var showResetView : Bool
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm = UserViewModel()
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top,10)
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Text("Forgot Password?")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            
            Text("Please enter the email so that we can send the reset link")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top,-5)
            
            VStack(spacing : 25 ){
                CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)
               
               
                GradientButton(title: "Send link", icon: "arrow.right"){
                    Task{
                        vm.ResetMail(email_FP:emailID){ success in
                            if success {
                                // Handle successful login
                               // showHome.toggle()
                                print("mail successful.")
                            } else {
                                // Handle login failure
                                print("Login failed.")
                            }
                        }
                        dismiss()
                        try? await Task.sleep(for: .seconds(0))
                        showResetView = true
                    }
                }.hSpacing(.trailing)
                    .disableWidthopacity(emailID.isEmpty)
            }
            .padding(.top,20)
          
           
        })
        .padding(.vertical,15)
        .padding(.horizontal,25)
        .interactiveDismissDisabled()
    }
}
#Preview {
    ForgotPasswordView(showResetView: .constant(true))
}
