//
//  CustomTF.swift
//  maladie
//
//  Created by Mohamed Amine Mtar on 20/11/2024.
//

import SwiftUI

struct CustomTF: View {
    var sfIcon : String
    var IconTint : Color = .gray
    var hint: String
    var isPassword : Bool = false
    @Binding var value : String
    @State var showPassword : Bool = false
    var body: some View {
        HStack(alignment: .top, content: {
            Image(systemName: sfIcon)
                .foregroundStyle(IconTint)
                .frame(width: 30)
                .offset(y:2)
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,spacing: 8, content: {
                if isPassword{
                    Group{
                        if showPassword {
                            TextField(hint,text: $value)
                        }
                        else{
                            SecureField(hint,text: $value)
                        }
                    }
                    

                }else{
                    TextField(hint,text: $value)
                }
                Divider()
            })
            .overlay(alignment: .trailing){
                if isPassword{
                    Button(action: {
                        withAnimation{
                            showPassword.toggle()
                        }
                    }, label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(.gray)
                            .padding(10)
                            .contentShape(.rect)
                    })
                }
            }
        })
    }
}

//#Preview {
//    CustomTF()
//}
