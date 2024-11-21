//
//  OTPView.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//

import SwiftUI

struct OTPView: View {
    @Binding var otpText :String
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
            
            Text("Enter OTP")
                .font(.largeTitle)
                .fontWeight(.heavy)
            Text("An 6 digit code has been sent to your Email")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top,-5)
            
            
            VStack(spacing : 25 ){
              OTPVerificationView(otpText: $otpText)
                GradientButton(title: "Reset", icon: "arrow.right"){
                    dismiss()
                }.hSpacing(.trailing)
                    .disableWidthopacity(otpText.isEmpty)
            }
            .padding(.top,20)
          
           
        })
        .padding(.vertical,15)
        .padding(.horizontal,25)
        .interactiveDismissDisabled()
    }
}

#Preview {
    OTPView(otpText: .constant("123456"))
}

