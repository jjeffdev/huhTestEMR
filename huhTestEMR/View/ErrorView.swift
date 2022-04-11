//
//  ErrorView.swift
//  huhTestEMR
//
//  Created by jeff on 3/3/22.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Error!")
                    .font(.title)
                    .padding()
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding()
                Spacer()
            }
            .padding()
            .cornerRadius(16)
            .background(.ultraThinMaterial)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case requiredError
    }
    
    static var staticErrorWrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.requiredError, guidance: "This error can be safely ignored--From Previews.")
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: staticErrorWrapper)
    }
}
