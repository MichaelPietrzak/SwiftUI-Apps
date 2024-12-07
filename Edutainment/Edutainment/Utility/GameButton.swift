//
//  GameButton.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 08/12/2024.
//

import SwiftUI

struct GameButton: View {
    var title: String
    var icon: String
    var color: Color
    var ifDisabled: Bool
    var action: () -> Void
    
    var body: some View {
        Button(title, systemImage: icon) {
            action()
        }
        .font(.headline.weight(.bold))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .foregroundStyle(color)
        .background(color.opacity(0.2))
        .clipShape(.rect(cornerRadius: 10))
        .disabled(ifDisabled)
    }
}

#Preview {
    GameButton(title: "Custom button", icon: "checkmark.circle", color: .blue, ifDisabled: false, action: {} )
}
