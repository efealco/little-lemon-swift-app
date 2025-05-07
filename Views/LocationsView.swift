import SwiftUI

struct LocationsView: View {
    @EnvironmentObject var model: Model  // ✅ Fix: Injected model environment object

    var body: some View {
        NavigationView {
            VStack {
                // Logo
                LittleLemonLogo()
                    .padding(.top)

                Text("Select a location")
                    .padding(.vertical, 10)
                    .padding(.horizontal, 40)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(20)
                    .padding(.bottom)

                // Use List for rows with separators
                List {
                    ForEach(model.restaurants) { restaurant in
                        NavigationLink(destination: ReservationForm(restaurant: restaurant)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(restaurant.city)
                                    .font(.headline)

                                HStack {
                                    Text(restaurant.neighborhood)
                                    Text("–")
                                    Text(restaurant.phoneNumber)
                                }
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                .listStyle(.plain)

            }
            .navigationBarHidden(true)
        }
    }
}
