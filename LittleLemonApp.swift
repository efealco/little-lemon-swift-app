//
//  LittleLemonApp.swift
//  LittleLemonApp
//
//  Created by Efe Alço on 6.05.2025.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    @StateObject var model = Model()
    
    var body: some Scene {
        WindowGroup {
                    MainView()
                        .environmentObject(model)
                }
    }
}
