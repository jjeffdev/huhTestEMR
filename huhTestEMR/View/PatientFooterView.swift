//
//  PatientFooterView.swift
//  huhTestEMR
//
//  Created by jeff on 2/15/22.
//

import SwiftUI

struct PatientFooterView: View {
    let handler: [PatientHandlerTimer.Speaker]
    var skipAction: () -> Void
    
    private var handlerNumber: Int? {
        guard let index = handler.firstIndex(where: {!$0.isCompleted}) else {return nil}
        return index + 1
    }
    
    private var isLastHandler: Bool {
        return handler.dropLast().allSatisfy { $0.isCompleted }
    }
    
    private var handlerText: String {
        guard let handlerNumber = handlerNumber else { return "No more handlers" }
        return "Handler \(handlerNumber) of \(handler.count)"
    }
    
    var body: some View {
        //why is the HStack wrapped in a VStack?
        VStack {
            HStack {
                if isLastHandler {
                    Text("Last Handler")
                } else {
                    Text(handlerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next Handler")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct PatientFooterView_Previews: PreviewProvider {
    static var previews: some View {
        PatientFooterView(handler: PatientInfo.data[0].patientHandlers.speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
