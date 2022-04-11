//
//  History.swift
//  huhTestEMR
//
//  Created by jeff on 2/18/22.
//

import Foundation

struct History: Identifiable, Codable {
    var id: UUID
    var date: Date
    var handlers: [PatientInfo.PatientHandler]
    //lenghtOfEncounterMinutes should've named it this
    var faceToFaceMinutes: Int
    
    init(id: UUID = UUID(), date: Date = Date(), handlers: [PatientInfo.PatientHandler], faceToFaceMinutes: Int) {
        self.id = id
        self.date = date
        self.handlers = handlers
        self.faceToFaceMinutes = faceToFaceMinutes
    }
}
