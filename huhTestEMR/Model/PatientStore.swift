//
//  PatientStore.swift
//  huhTestEMR
//
//  Created by jeff on 2/22/22.
//

import Foundation
import SwiftUI

class PatientStore: ObservableObject {
    @Published var patients: [PatientInfo] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("patients.data")
    }
    
    //the new way to write the code below iOS 15 and greater: async await. Previous method used callbacks and main queue running sinde a closure inside a bacground queue (nested closures) is confusing at first.

    static func load() async throws -> [PatientInfo] {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                case .failure(let error): continuation.resume(throwing: error)
                case .success(let patients): continuation.resume(returning: patients)
                }
            }
        }
    }
    
    static func load(completeion: @escaping (Result<[PatientInfo], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completeion(.success([]))
                    }
                    return
                }
                let patientInfo = try JSONDecoder().decode([PatientInfo].self, from: file.availableData)
                DispatchQueue.main.async {
                    completeion(.success(patientInfo))
                }
            } catch {
                DispatchQueue.main.async {
                    completeion(.failure(error))
                }
            }
        }
    }
    /*
     //get the file directory with func that throws
     //load func with completion that's escaping
        //dispatchQ in the background
        //do {try fileURL} catch {}
     */

    @discardableResult static func save(patients: [PatientInfo]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(patients: patients) { result in
                switch result {
                case .failure(let error): continuation.resume(throwing: error)
                case .success(let patients): continuation.resume(returning: patients)
                }
            }
        }
    }
    
    static func save(patients: [PatientInfo], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(patients)
                let outFile = try fileURL()
                try data.write(to: outFile)
                DispatchQueue.main.async {
                    completion(.success(patients.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}


