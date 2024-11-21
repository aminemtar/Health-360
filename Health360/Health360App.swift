//
//  Health360App.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//
import GoogleSignIn
import SwiftUI


private struct SafeAreaInsetsEnvironmentKey: EnvironmentKey {
    static let defaultValue: (top: CGFloat, bottom: CGFloat) = (0, 0)
}

extension EnvironmentValues {
    var safeAreaInsets: (top: CGFloat, bottom: CGFloat) {
        get { self[SafeAreaInsetsEnvironmentKey.self] }
        set { self[SafeAreaInsetsEnvironmentKey.self] = newValue }
    }
}
@main
struct Health360App: App {
    @ObservedObject var navigationViewModel = NavigationViewModel()
    @State private var safeAreaInsets: (top: CGFloat, bottom: CGFloat) = (0, 0)
    var body: some Scene {
        WindowGroup {
            ZStack {
                GeometryReader { proxy in
                    Color.clear.onAppear {
                        safeAreaInsets = (proxy.safeAreaInsets.top, proxy.safeAreaInsets.bottom)
                    }
                }
                NavigationStack(path: $navigationViewModel.navigationPath)
                {
                    ContentView()
                        
                        .navigationDestination(for: NavigationViewModel.Destination.self) { destination in
                            switch destination
                            {
                    
                            case .Home:
                                HomeView()
                                    .navigationBarBackButtonHidden(true)
                            case .SignIn:
                                Login()
                                    .navigationBarBackButtonHidden(true)
                            case .signUp:
                                SignUp()
                                    .navigationBarBackButtonHidden(true)
                            case .splash:
                                SplashScreenView()
                                    .navigationBarBackButtonHidden(true)

                           
                            
                            }
                        }
                }.navigationViewStyle(StackNavigationViewStyle())
                    .onOpenURL { url in
                        GIDSignIn.sharedInstance.handle(url)}
                    .environmentObject(navigationViewModel)
                    .environment(\.safeAreaInsets, safeAreaInsets)
                   
            }
        }
    }
    func application(
      _ app: UIApplication,
      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }

      // Handle other custom URL types.

      // If not handled by this app, return false.
      return false
    }
}
