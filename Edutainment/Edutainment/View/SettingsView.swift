//
//  SettingsView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 07/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var didDelete = false
    @State private var didCancel = false
    
    let rangeOfQuestions = [5, 10, 20]
    @ObservedObject var game: Game
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Display Name") {
                    HStack {
                        SFSymbol(name: "person.circle.fill")
                        TextField("Name", text: $game.settings.displayName)
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                    }
                }
                
                Section("Difficulty Range") {
                    HStack {
                        Spacer()
                        Text("\(game.settings.num1)")
                            .frame(width: 30)
                        SFSymbol(name: "arrow.backward.to.line.circle.fill")
                        SFSymbol(name: "arrow.forward.to.line.circle.fill")
                        Text("\(game.settings.num2)")
                            .frame(width: 30)
                        Spacer()
                    }
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    
                    HStack(spacing: 20) {
                        Stepper("", value: $game.settings.num1)
                        Spacer()
                        Stepper("", value: $game.settings.num2)
                        Spacer()
                    }
                }
                .listRowSeparator(.hidden)
                
                Section("Questions") {
                    Picker("Quantity", selection: $game.settings.numOfQuestions) {
                        ForEach(rangeOfQuestions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .pickerStyle(.navigationLink)
                }
                
                Section("Scoreboard") {
                    Button("Delete Scoreboard", role: .destructive, action: {
                        didDelete = true
                    })
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .alert("Delete Scoreboard", isPresented: $didDelete) {
                        Button("Cancel", role: .cancel) { }
                        Button("Delete Scoreboard", role: .destructive) {
                            game.scoreboard.scores = 0
                            game.scoreboard.questions = 0
                            game.scoreboard.rightAnswers = 0
                        }
                    } message: {
                        Text("Are you sure you want to delete your game scoreboard? This is irreversible and will remove all score statistics.")
                    }
                }
            }
            .font((.system(.caption, design: .rounded, weight: .regular)))
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitleFont()
            .interactiveDismissDisabled()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        didCancel = true
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .textStyle(font: .headline, weight: .regular, color: .blue)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        game.saveSettings()
                        dismiss()
                    } label: {
                        Text("Save")
                            .textStyle(font: .headline, weight: .semibold, color: .blue)
                    }
                }
            }
            .onDisappear {
                if didCancel == true {
                    game.savedSettings()
                }
            }
        }
    }
}

#Preview {
    SettingsView(game: Game())
}
