//
//  GameReviewView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 14/01/2025.
//

import SwiftUI

struct GameReviewView: View {
    var game: Game
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 10) {
                HStack {
                    Text("Questions asked")
                        .font((.system(.subheadline, design: .rounded, weight: .semibold)))
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 30)
                    Spacer()
                    Text("How you did")
                        .font((.system(.subheadline, design: .rounded, weight: .semibold)))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 30)
                
                List {
                    ForEach(0..<min(game.questionReview.count, game.checkReview.count), id: \.self) { index in
                        HStack {
                            Text(game.questionReview[index].question)
                                .font((.system(.headline, design: .rounded, weight: .semibold)))
                                .foregroundStyle(.primary)
                                .frame(width: 70)
                            Text("=")
                                .font((.system(.headline, design: .rounded, weight: .semibold)))
                                .foregroundStyle(.primary)
                                .frame(width: 30)
                            Text("\(game.questionReview[index].answer)")
                                .font((.system(.headline, design: .rounded, weight: .heavy)))
                                .foregroundStyle(.orange)
                                .frame(width: 30)
                            
                            Spacer()
                            Text("\(game.checkReview[index].userAnswer)")
                                .font((.system(.headline, design: .rounded, weight: .heavy)))
                                .foregroundStyle(.primary)
                                .frame(width: 30)
                            Image(systemName: "\(game.checkReview[index].checkmarkIcon)")
                                .font(.title2.weight(.heavy))
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(game.checkReview[index].ifRight ? .green : .red, game.checkReview[index].ifRight ? .green.opacity(0.2) : .red.opacity(0.2))
                                .imageScale(.large)
                        }
                        .padding(.horizontal, 10)
                        .listRowBackground(Color.yellow.opacity(0.0))
                    }
                }
                .frame(maxHeight: CGFloat(game.questionReview.count) * 60)
                .scrollContentBackground(.hidden)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10]))
                        .frame(maxWidth: .infinity, maxHeight: CGFloat(game.questionReview.count) * 60)
                        .foregroundStyle(.orange.opacity(0.2))
                        .padding(.top, -5)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Review")
            .navigationBarTitleDisplayMode(.inline)
            .navigationAppearance()
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
    GameReviewView(game: Game())
}

