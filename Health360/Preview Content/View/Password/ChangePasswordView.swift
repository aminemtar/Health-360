//
//  ChangePasswordView.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//

import SwiftUI

struct ChangePasswordView: View {
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm = UserViewModel()
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top,10)
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Text("Change Password")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            VStack(spacing : 25 ){
                CustomTF(sfIcon: "lock", hint: "Old Password", isPassword :true,value: $password)
                CustomTF(sfIcon: "lock", hint: "Confirm Password",isPassword :true, value: $confirmPassword)
                GradientButton(title: "Confirm", icon: "arrow.right"){
                    dismiss()
                    vm.ChnagePWD(oldpass: password, newpass: confirmPassword, userId: AppStorageManager.shared.userId ?? " "){ success in
                        if success {
                            print("changed password successful.")
                        } else {
                            // Handle login failure
                            print("change password failed.")
                        }
                    }
                }.hSpacing(.trailing)
                    .disableWidthopacity(password.isEmpty || confirmPassword.isEmpty)
            }
            .padding(.top,20)
        })
        .padding(.vertical,15)
        .padding(.horizontal,25)
        .interactiveDismissDisabled()
    }
}

#Preview {
    ChangePasswordView()
}
