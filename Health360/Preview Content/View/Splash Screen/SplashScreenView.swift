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
                        navigationViewModel.navigateTo(destination: .Home)
                    } else if AppStorageManager.shared.login{
                        navigationViewModel.navigateTo(destination: .Home)
                    } else {
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
