//
//  PatientDetailView.swift
//  huhTestEMR
//
//  Created by Jeff on 12/7/21.
//

import SwiftUI

struct PatientDetailView: View {
    @Binding var patient: PatientInfo
    
    @State private var data = PatientInfo.Data()
    @State private var isPresentingEditView = false
    
    
    var body: some View {
        List {
            Section(header: Text("Patient Info")) {
                NavigationLink(destination: PatientNoteView(patient: $patient)) {
                    Label("\(patient.name) - Progress note", systemImage: "note.text")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                    .accessibilityLabel(Text(patient.name))
                }
                HStack() {
                    Label(String(" Age \(patient.age)"), systemImage: "person.crop.circle.badge.clock.fill")
                    Spacer()
                    Label(String(patient.sex), systemImage: "dot.square")
                }
                HStack {
                    Label(String(patient.phoneNumber), systemImage: "phone")
                }
//                HStack {
                    Label(String(patient.address), systemImage: "book.closed")
//                }
                HStack {
                    Label(String("SSN: \(patient.socialSecurityNumber)"), systemImage: "lock.shield.fill")
                }
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(patient.theme.name)
                }
            }
            Section(header: Text("Patient Handlers")) {
                    ForEach(patient.patientHandlers) { handler in
                        Label(handler.name, systemImage: "person")
                            .accessibilityLabel(Text("Handlers"))
                            .accessibilityValue(handler.name)
                    }
            }
            Section(header: Text("History")) {
                if patient.history.isEmpty {
                    Label("No encounters yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(patient.history) { history in
                    HStack {
                        Image(systemName: "calendar")
                        Text(history.date, style: .date)
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(patient.name)
        .toolbar {
            Button("edit") {
                isPresentingEditView = true
                data = patient.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                PatientDetailEditVIew(data: $data)
                    .navigationTitle("\(patient.name)")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresentingEditView = false
                                patient.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct PatientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PatientDetailView(patient: .constant(PatientInfo.data[0]))
    }
    }
}
