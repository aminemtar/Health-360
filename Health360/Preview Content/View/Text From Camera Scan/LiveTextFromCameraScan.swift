//
//  LiveTextFromCameraScan.swift
//  maladie
//
//  Created by Mohamed Amine Mtar on 20/11/2024.
//

import SwiftUI

struct LiveTextFromCameraScan: View {
    @Environment(\.dismiss) var dismiss
    @Binding var liveScan: Bool
    @Binding var scannedText: String
    var body: some View {
        NavigationStack {
            VStack {
                DataScannerVC(scannedText: $scannedText, liveScan: $liveScan)
                Text("Capture Text")
                Button("Cancel") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Capture Text")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LiveTextFromCameraScan(liveScan: .constant(false), scannedText: .constant(""))
}
