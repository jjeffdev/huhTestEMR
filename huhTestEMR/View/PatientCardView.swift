//
//  PatientsList.swift
//  huhTestEMR
//
//  Created by Jeff on 12/1/21.
//

import SwiftUI

struct PatientCardView: View {
    var patient: PatientInfo
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Label(patient.name, systemImage: "person.circle")
                        .accessibilityElement(children: .ignore)
                        .accessibilityValue("\(patient.name)")
                    Label(String("Age \(patient.age), \(patient.sex)"), systemImage: "calendar.badge.clock")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Label("\(patient.phoneNumber)", systemImage: "phone.circle")
                    Label("Address \(patient.address)", systemImage: /*@START_MENU_TOKEN@*/"map.circle.fill"/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .padding()
    }
}

struct PatientsList_Previews: PreviewProvider {
    static var patientPreview = PatientInfo.data[0]
    static var previews: some View {
        PatientCardView(patient: patientPreview)
            .previewLayout(.fixed(width: 450, height: 100))
    }
}
