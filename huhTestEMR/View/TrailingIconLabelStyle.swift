//
//  TrailingIconLabelStyle.swift
//  huhTestEMR
//
//  Created by Jeff on 12/11/21.
//

import SwiftUI

// 

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}


//So, here we use Self (to reference the Type (LabelSytle) that conforms to the protocol (TrailingIconLabelStyle). If this had "self" it would reference the value held by the Type i.e. "Hello World".
extension LabelStyle where Self == TrailingIconLabelStyle {
    //static syntax allows you attatch this to the Type call without creating an instance of the Type first.
    static var trailingIcon: Self { Self() }
}

//call this in the PatientCardView as a modifier in the HStack on the Last label. 
