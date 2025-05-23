//
//  GameReviewView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 14/01/2025.
//

import SwiftUI

struct GameReviewView: View {
    @ObservedObject var game: Game
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 10) {
                HStack {
                    Text("Questions asked")
                        .textStyle(font: .subheadline, weight: .semibold, color: .secondary)
                        .padding(.horizontal, 30)
                    Spacer()
                    Text("How you did")
                        .textStyle(font: .subheadline, weight: .semibold, color: .secondary)
                }
                .padding(.horizontal, 30)
                
                List {
                    ForEach(0..<min(game.questionReview.count, game.checkReview.count), id: \.self) { index in
                        HStack {
                            Text(game.questionReview[index].question)
                                .textStyle(font: .headline, weight: .semibold, color: .primary)
                                .frame(width: 70)
                            Text("=")
                                .textStyle(font: .headline, weight: .semibold, color: .primary)
                                .frame(width: 30)
                            Text("\(game.questionReview[index].answer)")
                                .font((.system(.headline, design: .rounded, weight: .heavy)))
                                .foregroundStyle(.orange)
                                .textStyle(font: .headline, weight: .heavy, color: .orange)
                                .frame(width: 30)
                            Spacer()
                            Text("\(game.checkReview[index].userAnswer)")
                                .textStyle(font: .headline, weight: .heavy, color: .primary)
                                .frame(width: 30)
                            SFSymbol(name: "\(game.checkReview[index].checkmarkIcon)", primaryColor: game.checkReview[index].ifRight ? .green : .red, secondaryColor: game.checkReview[index].ifRight ? .green.opacity(0.2) : .red.opacity(0.2))
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
    GameReviewView(game: Game())
}
