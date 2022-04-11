//
//  PatientProgressViewStyle.swift
//  huhTestEMR
//
//  Created by jeff on 2/12/22.
//

import SwiftUI

struct PatientProgressViewStyle: ProgressViewStyle {
    var theme: Theme
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(theme.accentColor)
                .frame(height: 20)
            if #available(iOS 15, *) {
                ProgressView(configuration)
                    .tint(theme.mainColor)
                    .frame(height: 20)
                    .padding(.horizontal)
            } else {
                ProgressView(configuration)
                    .frame(height: 20)
                    .padding(.horizontal)
            }
        }
    }
}

struct PatientProgressViewStyle_Previews: PreviewProvider {
    static var previews: some View {
        //This gets even more confusing... Unlike the Trailing icon style, which we can't preview, we can call ProgressView, give it a constant value then add modifiers which call the ScrumProgressViewStyle.

        ProgressView(value: 0.4)
            .progressViewStyle(PatientProgressViewStyle(theme: .buttercup))
            .previewLayout(.sizeThatFits)
    }
}
