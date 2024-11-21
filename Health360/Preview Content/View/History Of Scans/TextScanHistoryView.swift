//
//  TextScanHistoryView.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//

import Foundation
import SwiftUI
struct TextScanHistoryView: View {

    let scanHistory: [TextScanResult] = [
        TextScanResult(text: "Apple", canEat: true),
        TextScanResult(text: "Peanuts", canEat: false),
        TextScanResult(text: "Orange", canEat: true),
        TextScanResult(text: "Gluten", canEat: false)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(scanHistory, id: \.text) { scan in
                    TextScanCard(scan: scan)
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

struct TextScanResult {
    var text: String
    var canEat: Bool
}



#Preview {
    TextScanHistoryView()
}
