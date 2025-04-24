//
//  ScoreboardView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 14/01/2025.
//

import SwiftUI

struct ScoreboardView: View {
    @ObservedObject var game: Game
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("You scored overall ")
                        .font((.system(.headline, design: .rounded, weight: .semibold)))
                        .foregroundStyle(.primary)
                    +
                    Text("\(game.scoreboard.scores) points")
                        .font((.system(.headline, design: .rounded, weight: .semibold)))
                        .foregroundStyle(.orange)
                    +
                    Text("!")
                        .font((.system(.headline, design: .rounded, weight: .semibold)))
                        .foregroundStyle(.primary)
                    SFSymbol(name: "trophy.fill", primaryColor: .yellow, scale: .small)
                }
                
                Spacer()
        
                ScoreDetails(questions: game.scoreboard.questions, answers: game.scoreboard.rightAnswers, bestTime: game.scoreboard.bestTime)
                
                VStack { }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Scoreboard")
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitleFont()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Close", systemImage: "square.and.arrow.down")
                            .labelStyle(.titleOnly)
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                    }
                }
            }
        }
    }
}

#Preview {
    ScoreboardView(game: Game())
}
