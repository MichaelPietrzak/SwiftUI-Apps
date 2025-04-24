//
//  SFSymbol.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 24/04/2025.
//

import SwiftUI

struct SFSymbol: View {
    var name: String
    var font: Font?
    var primaryColor: Color?
    var secondaryColor: Color?
    var scale: Image.Scale?
    
    var body: some View {
        Image(systemName: name)
            .font(font ?? .title2.weight(.heavy))
            .symbolRenderingMode(.palette)
            .foregroundStyle(primaryColor ?? .blue, secondaryColor ?? .blue.opacity(0.2))
            .imageScale(scale ?? .large)
    }
}

#Preview {
    SFSymbol(name: "arrow")
}
