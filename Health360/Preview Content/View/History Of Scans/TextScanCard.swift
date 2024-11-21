//
//  TextScanCard.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//

import Foundation

import SwiftUI

struct TextScanCard: View {
    var scan: TextScanResult
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(scan.text)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(scan.canEat ? "Can Eat" : "Can't Eat")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(scan.canEat ? Color.green : Color.red)
                    .cornerRadius(5)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    TextScanCard(scan: TextScanResult(text: "apple,sugar,caffeine", canEat: false))
}
