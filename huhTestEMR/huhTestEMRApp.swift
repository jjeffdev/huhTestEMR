//
//  huhTestEMRApp.swift
//  huhTestEMR
//
//  Created by Jeff on 11/28/21.
//

import SwiftUI

@main
struct huhTestEMRApp: App {
//    @State private var patient = PatientInfo.data
    @StateObject private var store = PatientStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PatientListView(patients: $store.patients) {
                    //since we added a property clousure in this view, here we can specify and pass a saveAction clousure. Remember the closure doesnt have be named and that as the last property it becomes a trailing clousure. After the call to PatientStore is made it'll do the action and then you have to handle the error. good luck understaing that part. a clousre within an a closure (nested)
                    
                    //this while block of code gets replaced by a more modern async code
//                    PatientStore.save(patients: store.patient) { result in
//                        if case .failure(let error) = result {
//                            fatalError(error.localizedDescription)
//                        }
//                    }
                    Task {
                        do {
                            try await PatientStore.save(patients: store.patients)
                        } catch {
//                            fatalError("Failed to save patients.")
                            errorWrapper = ErrorWrapper(error: error, guidance: "Error occured trying to save Patients.")
                        }
                    }
                }
            }
//             this modifier can also be modernized by using .task async modifier
//            .onAppear {
//                PatientStore.load { result in
//                    switch result {
//                    case .failure(let error): fatalError(error.localizedDescription)
//                        //based on if the result is sucessful assign it to a let constant, remember case :, assign and the constant
//                    case .success(let patients): store.patients = patients
//                    }
//                }
//            }
            //dont understand why this doesnt work--something about type () and []. Well, i rewrote the func method and now it works...
            .task {
                do {
                    store.patients = try await PatientStore.load()
                } catch {
//                    fatalError("Failed to load patients")
                    errorWrapper = ErrorWrapper(error: error, guidance: "Error occured trying to laod Patients. App will load sample data and continue.")
                    
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                store.patients = PatientInfo.data
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
