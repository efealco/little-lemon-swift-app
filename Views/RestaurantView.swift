//
//  RestaurantView.swift
//  LittleLemonApp
//
//  Created by Efe Alço on 6.05.2025.
//


import SwiftUI

struct RestaurantView: View {
    let restaurant: Restaurant

    var body: some View {
        VStack(alignment: .leading) {
            Text(restaurant.city)
                .font(.headline)
            Text(restaurant.neighborhood)
                .font(.subheadline)
            Text(restaurant.phoneNumber)
                .font(.caption)
        }
    }
}
