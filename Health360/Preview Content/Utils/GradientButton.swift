//
//  GradientButton.swift
//  maladie
//
//  Created by Mohamed Amine Mtar on 20/11/2024.
//

import SwiftUI

struct GradientButton: View {
    var title : String
    var icon : String
    var onClick: () -> ()
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing:15){
                Text(title)
                Image(systemName: icon)
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical,15)
            .padding(.horizontal,35)
            .background(.linearGradient(colors:[.purple,.purple,.purple], startPoint: .top, endPoint: .bottom),in:.capsule)
        })
    }
}

//#Preview {
//    GradientButton()
//}
