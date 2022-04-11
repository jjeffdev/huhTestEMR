//
//  TestEMRModel.swift
//  huhTestEMR
//
//  Created by Jeff on 11/29/21.
//

import SwiftUI

struct PatientInfo: Identifiable, Codable {
    var id: UUID
    var name: String
    //how to set a birthdate format
    //    var birthdate: Date
    var age: Int
    let sex: String
    //how to unwrap a nil to use in an stack view
    var socialSecurityNumber: Int
    //how to create a format for the date? how to create limit of input numbers (the lenght of a standard US phone number).
    var phoneNumber: Int
    //format for address with Int and String data types.
    var address: String
    //how to format first and last names?
    var patientHandlers: [PatientHandler]
    var faceToFaceMinutes: Int
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), name: String, age: Int, sex: String, socialSecurityNumber: Int, phoneNumber: Int, address: String, patientHandlers: [String], faceToFaceMinutes: Int, theme: Theme) {
        self.id = id
        self.name = name
        self.age = age
        self.sex = sex
        self.socialSecurityNumber = socialSecurityNumber
        self.phoneNumber = phoneNumber
        self.address = address
        //map(_:) creates a new collection by iterating over and applying a transformation to each element in an existing collection.
        self.patientHandlers = patientHandlers.map { PatientHandler(name: $0) }
        self.theme = theme
        self.faceToFaceMinutes = faceToFaceMinutes
    }
}

extension PatientInfo {
    struct PatientHandler: Identifiable, Codable {
        var id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    struct Data {
        var name: String = ""
        var age: Double = 0.0
        var sex: String = ""
        var socialSecurityNumber: Int = 000000000
        var phoneNumber: Int = 0
        var address: String = ""
        var patientHandler: [PatientHandler] = []
        var faceToFaceMinutes: Int = 0
        var theme: Theme = .buttercup
    }
    
    var data: Data {
        Data(name: name, age: Double(age), sex: sex, socialSecurityNumber: socialSecurityNumber, phoneNumber: phoneNumber, address: address, patientHandler: patientHandlers, faceToFaceMinutes: faceToFaceMinutes, theme: theme)
    }
    
    mutating func update(from data: Data) {
        name = data.name
        age = Int(data.age)
        patientHandlers = data.patientHandler
        //should it be able to change the time by the use? faceToFaceMinutes???
        theme = data.theme
    }
    
    init(data: Data) {
        id = UUID()
        name = data.name
        age = Int(data.age)
        sex = data.sex
        socialSecurityNumber = data.socialSecurityNumber
        phoneNumber = data.phoneNumber
        address = data.address
        patientHandlers = data.patientHandler
        faceToFaceMinutes = data.faceToFaceMinutes
        theme = data.theme
    }
}

extension PatientInfo {
    static var data: [PatientInfo] {
        [
            PatientInfo(name: "Willow Blend", age: 66, sex: "Female", socialSecurityNumber: 123456789, phoneNumber: 5555555555, address: "245 GCP, Bell, NY 11462", patientHandlers: ["Joff Jimmy", "Steven Ten", "Jackie Pie", "Kat Nice"], faceToFaceMinutes: 15, theme: .yellow),
            PatientInfo(name: "Veranda Coffee", age: 69, sex: "Female", socialSecurityNumber: 123456790, phoneNumber: 5555555556, address: "245 20 GCP, Belle, NY 11456", patientHandlers: ["Joff Jimmy", "Yippy Tim", "Raven Wing", "Eil Shock"], faceToFaceMinutes: 30, theme: .oxblood),
            PatientInfo(name: "Pike Roast", age: 72, sex: "Male", socialSecurityNumber: 123456791, phoneNumber: 5555555557, address: "24530 GCP, Beller, NY 11357", patientHandlers: ["Joff Jimmy", "Joe Jam", "Rupert Rug", "Spea Spike"], faceToFaceMinutes: 45, theme: .tan),
            PatientInfo(name: "Light Roast", age: 74, sex: "Male", socialSecurityNumber: 1234567892, phoneNumber: 5555555558, address: "24510 GCP, Ballerrose, NY 11303", patientHandlers: ["Gimmy Granger", "Green Potter", "Grey Fog", "Left Right"], faceToFaceMinutes: 60, theme: .periwinkle)
        ]
    }
}
