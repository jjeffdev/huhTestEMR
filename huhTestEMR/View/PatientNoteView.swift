//
//  ContentView.swift
//  huhTestEMR
//
//  Created by Jeff on 11/28/21.
//

import SwiftUI
import AVFoundation

struct PatientNoteView: View {
    @Binding var patient: PatientInfo
    @StateObject var patientHandlerTImer = PatientHandlerTimer()
    
    var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(patient.theme.mainColor)
            VStack() {
                PatientHeaderView(secondsElapsed: patientHandlerTImer.secondsElapsed, secondsRemaining: patientHandlerTImer.secondsRemaining, theme: patient.theme, patient: $patient)
                Spacer()
                Circle()
                    .strokeBorder(lineWidth: 24, antialiased: true)
                Spacer()
                PatientFooterView(handler: patientHandlerTImer.speakers, skipAction: patientHandlerTImer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(patient.theme.accentColor)
        .onAppear {
            patientHandlerTImer.reset(lengthInMinutes: patient.faceToFaceMinutes, attendees: patient.patientHandlers)
            patientHandlerTImer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            patientHandlerTImer.startScrum()
        }
        .onDisappear {
            patientHandlerTImer.stopScrum()
            let history = History(handlers: patient.patientHandlers, faceToFaceMinutes: patient.faceToFaceMinutes)
            patient.history.insert(history, at: 0)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PatientNoteView(patient: .constant(PatientInfo.data[3]))
    }
}
