//
//  GameOverView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 09/01/2025.
//

import SwiftUI

struct GameOverView: View {
    @State private var showScoreboard = false
    @State private var showGameReview = false
    @State private var fadeIn = false
    @State private var scores = [Int]()
    @State private var questions = [Int]()
    @State private var rightAnswers = [Int]()
    
    @ObservedObject var game: Game
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("You scored ")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.primary)
                +
                Text("\(game.currentGame[0].score) points")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.orange)
                
                +
                Text(" in ")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.primary)
                +
                Text("\(game.currentGame[0].category)")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.orange)
                +
                Text("!")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.primary)
                
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
                        Text("\(game.currentGame[0].numOfQuestions)")
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.orange)
                    }
                    .listRowBackground(Color.yellow.opacity(0.0))
                    
                    HStack {
                        Text("Right Answers")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("\(game.currentGame[0].rightAnswers)")
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.orange)
                    }
                    .listRowBackground(Color.yellow.opacity(0.0))
                    
                    HStack {
                        Text("Time")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("\(game.currentGame[0].time)")
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
                
                Spacer()
                
                Text("Let's review your answers")
                    .font((.system(.subheadline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.secondary)
                
                Button {
                    showGameReview = true
                } label: {
                    Image(systemName: "checklist")
                        .font((.system(.headline, design: .rounded, weight: .heavy)))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.primary, .primary.opacity(0.2))
                    
                    Text("Review")
                        .font((.system(.headline, design: .rounded, weight: .semibold)))
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(.blue.opacity(0.2))
                .clipShape(.rect(cornerRadius: 20))
                
                VStack { }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack {
                    NavigationLink {
                        GameView(game: game)
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.primary)
                        Text("New Game")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: 200, maxHeight: 40)
                    .background(.blue.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Spacer()
                    
                    NavigationLink {
                        StartView()
                    } label: {
                        Image(systemName: "house.fill")
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.primary)
                        Text("All Games")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: 200, maxHeight: 40)
                    .background(.blue.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 20))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Game Over")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .navigationAppearance()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showScoreboard = true
                    } label: {
                        Image(systemName: "list.clipboard.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, .primary.opacity(0.2))
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $showScoreboard) {
                ScoreboardView(game: game)
            }
            .sheet(isPresented: $showGameReview) {
                GameReviewView(game: game)
            }
            .opacity(fadeIn ? 1 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    fadeIn = true
                }
                getScoreboardValues()
            }
        }
    }
    
    func getScoreboardValues() {
        scores.append(game.currentGame[0].score)
        questions.append(game.currentGame[0].numOfQuestions)
        rightAnswers.append(game.currentGame[0].rightAnswers)
        
        let scoresSum = scores.reduce(0, +)
        let questionsSum = questions.reduce(0, +)
        let rightAnswersSum = rightAnswers.reduce(0, +)
    }
}

#Preview {
    GameOverView(game: Game())
}
