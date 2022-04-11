//
//  ErrorWrapper.swift
//  huhTestEMR
//
//  Created by jeff on 3/2/22.
//

import Foundation

struct ErrorWrapper: Identifiable {
    var id: UUID
    var error: Error
    var guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
