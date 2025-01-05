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
    @State private var displayName = ""
    
    let rangeOfQuestions = [5, 10, 20]
    var game: Game
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Display Name") {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.blue, .blue.opacity(0.2))
                            .imageScale(.large)
                        
                        TextField("Name", text: $displayName)
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                    }
                }
                
                Section("Difficulty Range") {
                    HStack {
                        Spacer()
                        Text("\(selectedNum1)")
                            .frame(width: 30)
                        
                        Image(systemName: "arrow.backward.to.line.circle.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.blue, .blue.opacity(0.2))
                            .imageScale(.large)
                        
                        Image(systemName: "arrow.forward.to.line.circle.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.blue, .blue.opacity(0.2))
                            .imageScale(.large)
                        
                        Text("\(selectedNum2)")
                            .frame(width: 30)
                        Spacer()
                    }
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    
                    HStack(spacing: 20) {
                        Stepper("", value: $selectedNum1)
                        Spacer()
                        Stepper("", value: $selectedNum2)
                        Spacer()
                    }
                }
                .listRowSeparator(.hidden)
                .padding(5)
                
                Section("Questions") {
                    Picker("Quantity", selection: $selectedNumOfQuestions) {
                        ForEach(rangeOfQuestions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .pickerStyle(.navigationLink)
                }
            }
            .font((.system(.caption, design: .rounded, weight: .regular)))
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationAppearance()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if !game.settings.isEmpty {
                            game.settings.removeLast()
                        }
                        
                        let settings = Settings(num1: selectedNum1, num2: selectedNum2, numOfQuestions: selectedNumOfQuestions)
                        game.settings.append(settings)
                        dismiss()
                    } label: {
                        Label("Save", systemImage: "square.and.arrow.down")
                            .labelStyle(.titleOnly)
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView(game: Game())
}
