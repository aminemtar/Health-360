//
//  NavigationViewModel.swift
//  maladie
//
//  Created by Mohamed Amine Mtar on 20/11/2024.
//

import Foundation
import SwiftUI

class NavigationViewModel:ObservableObject{
    
    
    @Published var navigationPath :NavigationPath = NavigationPath()
    
    func navigateTo(destination: Destination) {
    navigationPath.append(destination)
    }
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot()
    {
        navigationPath.removeLast(navigationPath.count)
    }
    
    enum Destination:Hashable {
        case splash
        case Home
        case SignIn
        case signUp
    }
    
    
}
