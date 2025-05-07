import SwiftUI

struct ReservationView: View {
    @EnvironmentObject var model: Model

    let labelWidth: CGFloat = 85

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    LittleLemonLogo()
                        .padding(.top)

                    Text("RESERVATION")
                        .font(.caption)
                        .kerning(1.5)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 30)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, alignment: .center)

                    // Check if reservationInfo is nil and show message if so
                    if let reservationInfo = model.reservationInfo {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("RESTAURANT")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.bottom, 2)

                            Text(model.selectedRestaurant?.city ?? "City")
                                .font(.title2)
                                .fontWeight(.medium)

                            HStack(spacing: 4) {
                                Text(model.selectedRestaurant?.neighborhood ?? "Neighborhood")
                                Text("–")
                                Text(model.selectedRestaurant?.phoneNumber ?? "Phone Number")
                            }
                            .font(.caption)
                            .foregroundColor(.gray)
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            DetailRow(label: "NAME:", value: reservationInfo.name, labelWidth: labelWidth)
                            DetailRow(label: "E-MAIL:", value: reservationInfo.email, labelWidth: labelWidth)
                            DetailRow(label: "PHONE:", value: reservationInfo.phoneNumber, labelWidth: labelWidth)
                            DetailRow(label: "PARTY:", value: "\(reservationInfo.party)", labelWidth: labelWidth)
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            DetailRow(label: "DATE:", value: formattedDate(reservationInfo.selectedDate), labelWidth: labelWidth)
                            DetailRow(label: "TIME:", value: formattedTime(reservationInfo.selectedTime), labelWidth: labelWidth)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text("SPECIAL REQUESTS:")
                                .font(.caption)
                                .foregroundColor(.gray)

                            Text(reservationInfo.specialRequest.isEmpty ? "None" : reservationInfo.specialRequest)
                                .font(.body)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    } else {
                        // Show no reservation message if reservationInfo is nil
                        Text("No reservation selected")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 20)
                    }

                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }

    func formattedTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: time)
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    let labelWidth: CGFloat

    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(width: labelWidth, alignment: .leading)

            Text(value)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        let previewModel = Model()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let sampleDate = dateFormatter.date(from: "2022/11/14 14:10") ?? Date()

        previewModel.selectedRestaurant = Restaurant(city: "Nevada", neighborhood: "Venice", phoneNumber: "(725) 555-5454")
        previewModel.reservationInfo = ReservationInfo(
            party: 1,
            name: "John Doe",
            phoneNumber: "(212) 555 1234",
            email: "johndoe@example.com",
            specialRequest: "I would like to order a cake",
            selectedDate: sampleDate,
            selectedTime: sampleDate
        )

        return ReservationView()
            .environmentObject(previewModel)
    }
}
