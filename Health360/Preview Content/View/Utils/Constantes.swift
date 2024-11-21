//
//  Constantes.swift
//  maladie
//
//  Created by Mohamed Amine Mtar on 20/11/2024.
//
import SwiftUI
class SafeAreaManager {
    static let shared = SafeAreaManager()
    var topInset: CGFloat = 59
    var bottomInset: CGFloat = 0
}

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
