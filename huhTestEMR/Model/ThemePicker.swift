//
//  ThemePickerView.swift
//  huhTestEMR
//
//  Created by jeff on 2/2/22.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: selection)
                    .tag(theme)
            }
        }
    }
}

struct ThemePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle))
    }
}
