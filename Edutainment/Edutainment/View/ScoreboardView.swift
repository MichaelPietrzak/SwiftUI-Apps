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
                HStack(spacing: 0) {
                    Text("You scored overall ")
                        .textStyle(font: .headline, weight: .semibold, color: .primary)
                    Text("\(game.scoreboard.scores) points")
                        .textStyle(font: .headline, weight: .semibold, color: .orange)
                    Text("!")
                        .textStyle(font: .headline, weight: .semibold, color: .primary)
                    SFSymbol(name: "trophy.fill", primaryColor: .yellow, scale: .small)
                        .padding(.leading, 10)
                }
                
                Spacer()
        
                ScoreDetails(questions: game.scoreboard.questions, answers: game.scoreboard.rightAnswers)
                
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
                        Text("Close")
                            .textStyle(font: .headline, weight: .semibold, color: .blue)
                    }
                }
            }
        }
    }
}

#Preview {
    ScoreboardView(game: Game())
}
