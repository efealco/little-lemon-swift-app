//
//  Restaurant.swift
//  LittleLemonApp
//
//  Created by Efe Alço on 6.05.2025.
//

import Foundation

struct Restaurant: Identifiable {
    let id = UUID()
    let city: String
    let neighborhood: String
    let phoneNumber: String
}

struct ReservationInfo {
    var party: Int
    var name: String
    var phoneNumber: String
    var email: String
    var specialRequest: String
    var selectedDate: Date
    var selectedTime: Date
}

class Model: ObservableObject {
    @Published var selectedRestaurant: Restaurant?
    @Published var reservationInfo: ReservationInfo?
    @Published var displayingReservationForm = false
    @Published var tabViewSelectedIndex = 0
    @Published var restaurants = [
        Restaurant(city: "Chicago", neighborhood: "Downtown", phoneNumber: "123-456-7890"),
        Restaurant(city: "New York", neighborhood: "Brooklyn", phoneNumber: "234-567-8901"),
        Restaurant(city: "Los Angeles", neighborhood: "Hollywood", phoneNumber: "345-678-9012")
    ]
    
    func confirmReservation(party: Int, name: String, phoneNumber: String, email: String, specialRequest: String, selectedDate: Date, selectedTime: Date) {
        reservationInfo = ReservationInfo(
            party: party,
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            specialRequest: specialRequest,
            selectedDate: selectedDate,
            selectedTime: selectedTime
        )
    }
}
