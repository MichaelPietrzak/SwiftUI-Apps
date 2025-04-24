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
                Text("Let's check how you did below")
                    .font((.system(.subheadline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.secondary)
                
                List {
                    HStack {
                        Text("Questions")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("\(game.scoreboard.questions)")
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.orange)
                    }
                    .listRowBackground(Color.yellow.opacity(0.0))
                    
                    HStack {
                        Text("Right Answers")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("\(game.scoreboard.rightAnswers)")
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.orange)
                    }
                    .listRowBackground(Color.yellow.opacity(0.0))
                    
                    HStack {
                        Text("Best Time")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("\(game.scoreboard.bestTime)")
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.orange)
                    }
                    .listRowBackground(Color.yellow.opacity(0.0))
                }
                .frame(maxHeight: 180)
                .padding(.top, -30)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10]))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(.orange.opacity(0.2))
                        .padding(.top, -5)
                }
                
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
