//
//  PatientListView.swift
//  huhTestEMR
//
//  Created by Jeff on 12/2/21.
//

import SwiftUI

struct PatientListView: View {
    @Binding var patients: [PatientInfo]
    @Environment(\.scenePhase) private var scenePhase
    @State var isPresentingNewPatientView = false
    @State var newPatientData = PatientInfo.Data()
//    think about why we use let here for an empty action
    let saveAction: ()->Void
    
    var body: some View {
        //make a List, then ForEach
        List {
            ForEach($patients) { $patient in
                NavigationLink(destination: PatientDetailView(patient: $patient)) {
                    PatientCardView(patient: patient)
                    //skipping the background color for each
                }
                .listRowBackground(patient.theme.mainColor)
            }
        }
        .navigationTitle(Text("Patient List"))
        .navigationBarItems(trailing: Button(action: {
            isPresentingNewPatientView = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isPresentingNewPatientView) {
            NavigationView {
                PatientDetailEditVIew(data: $newPatientData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewPatientView = false
                                newPatientData = PatientInfo.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                //how do we init this data? Create init method in PatientInfo of type Data that captures new data by the user (not the already stored data).
                                let newPatient = PatientInfo(data: newPatientData)
                                patients.append(newPatient)
                                isPresentingNewPatientView = false
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct PatientListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PatientListView(patients: .constant(PatientInfo.data), saveAction: {})
        }
    }
}
