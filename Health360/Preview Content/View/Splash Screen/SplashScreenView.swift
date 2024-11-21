//
//  SplashScreenView.swift
//  maladie
//
//  Created by Mohamed Amine Mtar on 20/11/2024.
//

import SwiftUI
import DotLottie

struct SplashScreenView: View {
    @StateObject private var googleSignInVM = GoogleSignInVM()
    @State private var navigateToSignInView = false
    @State private var navigateToHomeView = false
    @EnvironmentObject var navigationViewModel: NavigationViewModel

    var body: some View {
      
            VStack {
                DotLottieAnimation(fileName: "splash", config: AnimationConfig(autoplay: true, loop: true)).view()

                Text("©Health360 ")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.purple)

                Spacer()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    if googleSignInVM.isLoggedIn {
                        navigateToHomeView = true
                        navigationViewModel.navigateTo(destination: .Home)
                    } else {
                        navigateToSignInView = true
                        navigationViewModel.navigateTo(destination: .SignIn)
                    }
                }
            }
            
    }
}

#Preview {
    SplashScreenView()
        .environmentObject(NavigationViewModel())
}
