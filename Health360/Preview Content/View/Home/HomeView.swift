//
//  HomeView.swift
//  Health360
//
//  Created by Mohamed Amine Mtar on 21/11/2024.
//

import Foundation

import SwiftUI

struct HomeView: View {
    @State var selectedTab: BottomBarSelectedTab = .home
    @StateObject private var googleSignInVM = GoogleSignInVM()
    
    var body: some View {
        VStack {
//            HStack {
//                if let url = URL(string: googleSignInVM.profilePicUrl) {
//                    AsyncImage(url: url) { image in
//                        image
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 50, height: 50)
//                            .clipShape(Circle())
//                    } placeholder: {
//                        ProgressView()
//                    }
//
//                } else {
//                    Circle()
//                        .fill(Color.gray)
//                        .frame(width: 40, height: 40)
//                }
//
//
//                VStack(alignment: .leading) {
//                    Text(googleSignInVM.givenName)
//                        .font(.headline)
//                        .foregroundColor(.gray)
//                }
//
//                Spacer()
//            }
//            .padding()
//            .background(Color.purple.opacity(0.1))
            
            VStack {
                if selectedTab == .home {
                    TextScanHistoryView()
                }
                
                if selectedTab == .plus {
                    CameraEntry()
                }
                
                if selectedTab == .profile {
                    ProfilePage()
                }
                
                Spacer()
                BottomBar(selectedTab: $selectedTab)
            }
        }
        .onAppear {
            googleSignInVM.checkStatus()
        }
    }
}

#Preview {
    HomeView()
}
