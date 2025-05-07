import SwiftUI

struct ReservationForm: View {
    @EnvironmentObject var model: Model
    let restaurant: Restaurant

    @State private var party: Int = 1
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var specialRequest: String = ""
    @State private var selectedDate: Date = Calendar.current.date(from: DateComponents(year: 2022, month: 11, day: 9)) ?? Date()
    @State private var selectedTime: Date = Calendar.current.date(bySettingHour: 13, minute: 33, second: 0, of: Date()) ?? Date()

    @State private var errorMessage: String = ""
    @State private var showFormInvalidMessage: Bool = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Top Restaurant Info
                VStack(alignment: .leading) {
                    Text(restaurant.city)
                        .font(.largeTitle)
                        .fontWeight(.medium) // Less bold than .bold()
                    
                    HStack(spacing: 4) {
                        Text(restaurant.neighborhood)
                        Text("–")
                        Text(restaurant.phoneNumber)
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading) // Align the whole VStack to the left
                Divider()

                // Party Size, Date, and Time Row
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("PARTY")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .bold()
                        HStack {
                            Text("\(party)")
                                .font(.title3)
                            Stepper("", value: $party, in: 1...20)
                                .labelsHidden()
                        }
                    }

                    Spacer()

                    VStack(alignment: .trailing) {
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                            .labelsHidden()
                            .padding(.vertical, -5)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                            .fixedSize()
                    }

                    VStack(alignment: .trailing) {
                        DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .padding(.vertical, -5)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                            .fixedSize()
                    }
                }
                .padding(.bottom)

                Divider()

                // Contact Information Section
                VStack(spacing: 15) {
                    HStack {
                        Text("NAME:")
                            .font(.callout)
                            .foregroundColor(.black)
                            .bold()
                            .frame(width: 80, alignment: .leading) // Slightly wider width for consistency
                        TextField("Your name...", text: $name)
                    }
                    Divider()
                    HStack {
                        Text("PHONE:")
                            .font(.callout)
                            .foregroundColor(.black)
                            .bold()
                            .frame(width: 80, alignment: .leading)
                        TextField("Your phone number...", text: $phoneNumber)
                            .keyboardType(.phonePad)
                    }
                    Divider()
                    HStack {
                        Text("E-MAIL:")
                             .font(.callout)
                             .foregroundColor(.black)
                             .bold()
                             .frame(width: 80, alignment: .leading)
                        TextField("Your e-mail...", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    Divider()
                }
                .padding(.bottom)

                // Special Request Input
                TextField("Add any special request (optional)", text: $specialRequest, axis: .vertical)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .lineLimit(3...)
                    .padding(.bottom)

                // Confirm Reservation Button
                Button(action: {
                    validateForm()
                    if !showFormInvalidMessage {
                        // Save reservation data to the model
                        model.confirmReservation(
                            party: party,
                            name: name,
                            phoneNumber: phoneNumber,
                            email: email,
                            specialRequest: specialRequest,
                            selectedDate: selectedDate,
                            selectedTime: selectedTime
                        )
                        // Optionally, dismiss the view or navigate to the next view
                        // presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("CONFIRM RESERVATION")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 30)
                        .background(Color.blue)
                        .cornerRadius(20)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
        }
        .alert(isPresented: $showFormInvalidMessage) {
            Alert(
                title: Text("ERROR"),  // Changed title to "ERROR"
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func validateForm() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        var errors: [String] = []

        if trimmedName.count < 3 || !trimmedName.allSatisfy({ $0.isLetter || $0.isWhitespace }) {
            errors.append("Names can only contain letters and must have at least 3 characters.")
        }

        if trimmedPhone.isEmpty {
            errors.append("The phone number cannot be blank.")
        } else if !trimmedPhone.allSatisfy({ $0.isNumber || $0 == "-" || $0 == "(" || $0 == ")" || $0 == " "}) || trimmedPhone.filter({$0.isNumber}).count < 7 {
            errors.append("Please enter a valid phone number.")
        }

        if !isValidEmail(trimmedEmail) {
            errors.append("The e-mail is invalid and cannot be blank.")
        }

        if errors.isEmpty {
            model.reservationInfo = ReservationInfo(
                party: party,
                name: name,
                phoneNumber: phoneNumber,
                email: email,
                specialRequest: specialRequest,
                selectedDate: selectedDate,
                selectedTime: selectedTime
            )

            errorMessage = "Reservation Confirmed!"
        } else {
            errorMessage = "Found these errors in the form:\n\n\(errors.joined(separator: "\n\n"))"
        }

        // Show error alert
        showFormInvalidMessage = true
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}

struct ReservationForm_Previews: PreviewProvider {
    static var previews: some View {
        ReservationForm(restaurant: Restaurant(city: "Las Vegas", neighborhood: "Downtown", phoneNumber: "(702) 555-9898"))
    }
}
