//
//  OTPVerificationView.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//



import Foundation
import SwiftUI
struct OTPVerificationView: View {
    @Binding var otpText : String
    @FocusState private var isKeyboardshowing : Bool
    var body: some View {
        HStack(spacing: 0){
            ForEach(0..<6 ,id: \.self){ index in
                OTPTextBox(index)
                
            }
        }.background(content:{
            TextField("",text: $otpText.limit(6))
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .frame(width: 1 , height: 1)
                .opacity(0.001)
                .blendMode(.screen)
                .focused($isKeyboardshowing)
        })
        .contentShape(Rectangle())
        .onTapGesture {
            isKeyboardshowing.toggle()
        }
            .toolbar{
                ToolbarItem(placement: .keyboard){
                    Button("Done"){
                        isKeyboardshowing.toggle()
                    }
                    .frame(width: .infinity, alignment: .trailing)
                }
            }
        }
    @ViewBuilder
    func OTPTextBox(_ index:Int) -> some View{
        ZStack{
            if otpText.count > index {
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex , offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
                
            } else {
                Text(" ")
            }
        }
        .frame(width: 45, height: 45)
        .background{
            let status = (isKeyboardshowing && otpText.count == index)
            RoundedRectangle(cornerRadius: 6, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .stroke(status ? .black : .gray,lineWidth: status ? 1 : 0.5)
                .animation(.easeInOut(duration: 0.2), value: status)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
    }



extension Binding where Value == String{
    func limit(_ length:Int) ->Self{
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
