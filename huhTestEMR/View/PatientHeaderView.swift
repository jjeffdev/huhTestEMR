//
//  PatientHeaderView.swift
//  huhTestEMR
//
//  Created by jeff on 2/11/22.
//

import SwiftUI

struct PatientHeaderView: View {
    var secondsElapsed: Int
    var secondsRemaining: Int
    var theme: Theme
    @Binding var patient: PatientInfo
    
    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    private var calculateProgress: Double {
        guard totalSeconds > 0 else {return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    var body: some View {
        VStack {
            Text(patient.name)
                     .padding()
            //This progress view should be in relation to units achieved but for now it will be minutes spent with patient.
            ProgressView(value: calculateProgress)
                .padding(.bottom)
                .progressViewStyle(PatientProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                    Text("\(secondsElapsed)")
                    Image(systemName: "hourglass.bottomhalf.fill")
                }
                Spacer()
                //Label("Goal Status", systemImage: "heart.text.square")
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                    Text("\(secondsRemaining)")
                    Image(systemName: "hourglass.tophalf.fill")
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding(.horizontal)
    }
}

struct PatientHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PatientHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .buttercup, patient: .constant(PatientInfo.data[0]))
            .previewLayout(.sizeThatFits)
    }
}
