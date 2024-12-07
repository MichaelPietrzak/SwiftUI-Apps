//
//  SettingsView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 07/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedNum1 = 0
    @State private var selectedNum2 = 0
    @State private var selectedNumOfQuestions = 5
    
    let rangeOfQuestions = [5, 10, 20]
    var game: Game
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Select 2 numbers for difficulty range") {
                        Stepper("\(selectedNum1)", value: $selectedNum1)
                        Stepper("\(selectedNum2)", value: $selectedNum2)
                    }
                    
                    Section("Select number of questions to be asked") {
                        Picker("numbers of questions", selection: $selectedNumOfQuestions) {
                            ForEach(rangeOfQuestions, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                GameButton(title: "Save", icon: "square.and.arrow.down", color: .blue, ifDisabled: false) {
                    let settings = Settings(num1: selectedNum1, num2: selectedNum2, NumOfQuestions: selectedNumOfQuestions)
                    game.settings.append(settings)
                    dismiss()
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .bold()
        }
    }
}

#Preview {
    SettingsView(game: Game())
}
