import SwiftUI

struct MainView: View {
    @EnvironmentObject var model: Model

    var body: some View {
        VStack {
            TabView(selection: $model.tabViewSelectedIndex) {
                LocationsView()
                    .tabItem {
                        Label(
                            model.displayingReservationForm ? "Reservation" : "Locations",
                            systemImage: model.displayingReservationForm ? "calendar" : "fork.knife"
                        )
                    }
                    .tag(0)
                
                ReservationView()
                    .tabItem {
                        Label("Reservation", systemImage: "square.and.pencil")
                    }
                    .tag(1)
            }
        }
        .padding(.horizontal)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Model())
    }
}
