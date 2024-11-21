//
//  TextFromImageView.swift
//  maladie
//
//  Created by Mohamed Amine Mtar on 20/11/2024.
//

import SwiftUI

struct TextFromImageView: View {
    @Environment(\.dismiss) var dismiss
    private let pastboard = UIPasteboard.general
    let imageToScan: UIImage
    @Binding var scannedText: String
    
    @State private var currentPastboard = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                LiveTextUIImageView(image: imageToScan)
                Text("Select some text and copy it")
                Button("Dismiss") {
                    if let string = pastboard.string {
                        if !string.isEmpty {
                            scannedText = string
                        }
                    }
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Copy Text")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                pastboard.string = ""
            }
        }
    }
}
#Preview {
    TextFromImageView(imageToScan: UIImage(), scannedText: .constant(""))
}
