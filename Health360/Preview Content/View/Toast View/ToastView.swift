//
//  ToastView.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//

import SwiftUI

struct ToastView: View {
    let message: String
    let backgroundColor: Color

    var body: some View {
        Text(message)
            .font(.body)
            .foregroundColor(.white)
            .padding()
            .background(backgroundColor)
            .cornerRadius(8)
            .shadow(radius: 10)
    }
}
#Preview {
    ToastView(message: "this toast is for preview", backgroundColor: .green)
}


struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let backgroundColor: Color
    let duration: Double

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                VStack {
                    Spacer()
                    ToastView(message: message, backgroundColor: backgroundColor)
                        .transition(AnyTransition.opacity.combined(with: .move(edge: .bottom)))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        }
                }
                .padding(.bottom, 50)
            }
        }
    }
}
extension View {
    func toast(
        isPresented: Binding<Bool>,
        message: String,
        backgroundColor: Color = .black,
        duration: Double = 2.0
    ) -> some View {
        self.modifier(ToastModifier(
            isPresented: isPresented,
            message: message,
            backgroundColor: backgroundColor,
            duration: duration
        ))
    }
}
