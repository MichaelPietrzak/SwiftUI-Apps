//
//  TextStyleModifier.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 24/04/2025.
//

import SwiftUI

struct TextStyleModifier: ViewModifier {
    var font: Font.TextStyle
    var weight: Font.Weight
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font((.system(font, design: .rounded, weight: weight)))
            .foregroundStyle(color)
    }
}

extension View {
    func textStyle(font: Font.TextStyle, weight: Font.Weight, color: Color) -> some View {
        modifier(TextStyleModifier(font: font, weight: weight, color: color))
    }
}
