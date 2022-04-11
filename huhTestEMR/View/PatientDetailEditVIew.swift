//
//  PatientDetailEditVIew.swift
//  huhTestEMR
//
//  Created by jeff on 1/15/22.
//

import SwiftUI

struct PatientDetailEditVIew: View {
    @Binding var data: PatientInfo.Data
    @State private var addNewHandler = ""
    
    var body: some View {
        Form {
            Section(header: Text("Patient Information")) {
                TextField("Patient Name", text: $data.name)
                HStack {
                    Slider(value: $data.age, in: 0...122, step: 1) {
                        Text("Patient's age")
                    }
                    .accessibilityValue("Age is \(data.age)")
                    Spacer()
                    Text("Age: \(Int(data.age))")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $data.theme)
            }
            Section(header: Text("Patient Handlers")) {
                ForEach(data.patientHandler) { handler in
                    Text(handler.name)
                }
                .onDelete { indices in
                    data.patientHandler.remove(atOffsets: indices)
                }
                HStack {
                    TextField("Add Handler", text: $addNewHandler)
                    //some random modifications
                        .textFieldStyle(.roundedBorder)
//                        .keyboardType(.emailAddress)
                    Button(action: {
                        withAnimation {
                            let attendee = PatientInfo.PatientHandler.init(name: addNewHandler)
                            data.patientHandler.append(attendee)
                            addNewHandler = ""
                        }
                    } ) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add handler")
                    }
                    .disabled(addNewHandler.isEmpty)
                }
            }
        }
    }
}

struct PatientDetailEditVIew_Previews: PreviewProvider {
    static var previews: some View {
        PatientDetailEditVIew(data: .constant(PatientInfo.data[0].data))
    }
}
