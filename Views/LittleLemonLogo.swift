//
//  LogoView.swift
//  LittleLemonApp
//
//  Created by Efe Alço on 6.05.2025.
//


import SwiftUI

struct LittleLemonLogo: View {
    var body: some View {
        VStack {
            Image("LittleLemon_Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 100)
        }
    }
}

#Preview {
    LittleLemonLogo()
}
