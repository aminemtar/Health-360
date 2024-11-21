//
//  ResetView.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//

import SwiftUI

struct ResetView: View {
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    @Environment(\.dismiss) private var dismiss
    
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
            
            Text("Reset Password")
                .font(.largeTitle)
                .fontWeight(.heavy)
           
            
            
            VStack(spacing : 25 ){
                CustomTF(sfIcon: "lock", hint: "Password", value: $password)
                CustomTF(sfIcon: "lock", hint: "Confirm Password", value: $confirmPassword)
                GradientButton(title: "Send link", icon: "arrow.right"){
                    dismiss()
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
    ResetView()
}

