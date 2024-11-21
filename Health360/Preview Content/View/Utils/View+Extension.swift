//
//  View+Extension.swift
//  maladie
//
//  Created by Mohamed Amine Mtar on 20/11/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignement : Alignment = .center) -> some View{
        self
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: alignement)
    }
    @ViewBuilder
    func vSpacing(_ alignement : Alignment = .center) -> some View{
        self
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: alignement)
    }
    @ViewBuilder
    func disableWidthopacity(_ condition:Bool) -> some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.5 : 1)
        
    }
}
