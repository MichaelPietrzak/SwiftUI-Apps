//
//  GameView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 29/10/2024.
//

import SwiftUI

struct GameView: View {
    @State private var currentQuestion = ""
    @State private var userAnswer = ""
    @State private var score = 0
    @State private var questionNumber = 0
    @State private var showSettings = false
    @State private var ifEndGame = false
    @State private var navigateToGameOver = false
    
    @Environment(\.dismiss) var dismiss
    
    var game: Game
    
    var keyboardValue: String {
        game.keyboard.isEmpty ? "?" : game.keyboard.map({ $0.key }).joined()
    }
    
    var progressValue: Double {
        game.settings.isEmpty ? Double(questionNumber) / Double(Settings.mockData[0].numOfQuestions) : Double(questionNumber) / Double(game.settings[0].numOfQuestions)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 30) {
                VStack(spacing: 5) {
                    ProgressView(value: progressValue)
                        .progressViewStyle(.linear)
                        .tint(.orange)
                    HStack {
                        Spacer()
                        Text("Question")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.secondary)
                        Text("\(questionNumber + 1)")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.custom)
                    }
                }
                
                Text("02:30")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [1]))
                            .foregroundStyle(.orange)
                    }
                
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10]))
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .foregroundStyle(.orange.opacity(0.2))
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "trophy.circle.fill")
                                    .font(.title2.weight(.heavy))
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.yellow, .black)
                                    .imageScale(.large)
                                Text("\(score)")
                                    .frame(width: 23)
                                    .foregroundStyle(.black)
                                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .padding(.trailing, 15)
                            VStack {
                                Text(currentQuestion)
                                    .foregroundStyle(.black)
                                    .font((.system(.largeTitle, design: .rounded, weight: .black)))
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .padding(.bottom, 50)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 160)
                        .background(.orange.opacity(0.8))
                        .clipShape(.rect(cornerRadius: 20))
                        .mask {
                            Rectangle()
                                .overlay (
                                    VStack {
                                    }
                                        .frame(maxWidth: .infinity, maxHeight: 50)
                                        .background(.black)
                                        .clipShape(.rect(cornerRadius: 20))
                                        .offset(y: 75)
                                        .blendMode(.destinationOut)
                                )
                                .compositingGroup()
                        }
                        .offset(y: -20)
                    }
                    .shadow(radius: 10)
                    
                    Text(keyboardValue)
                        .font((.system(.title, design: .rounded, weight: .bold)))
                        .foregroundStyle(.custom)
                        .padding(.top, -60)
                }
                
                KeyboardView(game: game)
                
                HStack {
                    Spacer()
                    Button {
                        checkNextQuestion()
                    } label: {
                        Image(systemName: "arrow.right")
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: 100, maxHeight: 40)
                    .background(.blue.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 20))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Multiplication")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationAppearance()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "pause.circle.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, .primary.opacity(0.2))
                            .imageScale(.large)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        ifEndGame = true
                    } label: {
                        Image(systemName: "house.circle.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, .primary.opacity(0.2))
                            .imageScale(.large)
                    }
                    .alert("End Game", isPresented: $ifEndGame) {
                        Button("Cancel", role: .cancel) { }
                        Button("End Game", role: .destructive) {
                            dismiss()
                        }
                    } message: {
                        Text("Are you sure you want to end your game?")
                    }
                }
            }
            .onAppear(perform: {
                game.settings.isEmpty ? print("Empty settings") : getQuestions()
            })
            .navigationDestination(isPresented: $navigateToGameOver) {
                GameOverView(game: game)
                    .onAppear {
                        newGame()
                    }
            }
        }
    }
    
    func getQuestions() {
        var rangeBounds = 0...0
        
        if game.settings[0].num1 > game.settings[0].num2 {
            rangeBounds = (game.settings[0].num2...game.settings[0].num1)
        } else {
            rangeBounds = (game.settings[0].num1...game.settings[0].num2)
        }
        
        for _ in 1...game.settings[0].numOfQuestions {
            let rangePair = [Int.random(in: rangeBounds), Int.random(in: rangeBounds)]
            
            let question = "\(rangePair[0]) x \(rangePair[1])"
            let answer = rangePair.reduce(1, *)
            
            let item = Question(text: question, answer: answer)
            game.questions.append(item)
        }
        loadQuestions()
    }
    
    func loadQuestions() {
        if currentQuestion.isEmpty {
            currentQuestion = game.questions.first?.text ?? "0 x 0"
        } else {
            questionNumber += 1
            currentQuestion = game.questions[questionNumber].text
        }
    }
    
    func checkNextQuestion() {
        userAnswer = keyboardValue
        let value = Int(userAnswer) ?? 0
        
        if value == game.questions[questionNumber].answer {
            score += 1
        } else {
            score += 0
        }
        
        if questionNumber + 1 < game.settings[0].numOfQuestions {
            loadQuestions()
            game.keyboard.removeAll()
        } else {
            let stats = CurrentGame(score: score, category: "multiplication", numOfQuestions: game.settings[0].numOfQuestions, rightAnswers: score, time: "2:30")
            game.currentGame.append(stats)
            navigateToGameOver = true
        }
    }
    
    func newGame() {
        game.keyboard.removeAll()
        game.questions.removeAll()
        game.scoreboard.removeAll()
        
        if game.currentGame.count > 1 {
            game.currentGame.removeFirst()
        }
    }
}

#Preview {
    GameView(game: Game())
}
