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
    @State private var ifRightAnswer = false
    @State private var ifRightAnswerIcon = ""
    @State private var showSettings = false
    @State private var ifEndGame = false
    @State private var navigateToGameOver = false
    @State private var navigateToStartView = false
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var game: Game
    
    var keyboardValue: String {
        game.keyboard.isEmpty ? "?" : game.keyboard.map({ $0.key }).joined()
    }
    
    var progressValue: Double {
        Double(questionNumber) / Double(game.settings.numOfQuestions)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 30) {
                VStack(spacing: 5) {
                    ProgressView(value: progressValue)
                        .progressViewStyle(.linear)
                        .tint(.orange)
                    HStack(spacing: 0) {
                        Spacer()
                        Text("\(questionNumber + 1)")
                            .textStyle(font: .headline, weight: .semibold, color: .custom)
                        Text(" / ")
                            .textStyle(font: .headline, weight: .semibold, color: .custom)
                        Text("\(game.settings.numOfQuestions)")
                            .textStyle(font: .headline, weight: .heavy, color: .orange.opacity(0.8))
                    }
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
                                SFSymbol(name: "trophy.circle.fill", primaryColor: .yellow, secondaryColor: .black)
                                Text("\(score)")
                                    .frame(width: 23)
                                    .textStyle(font: .headline, weight: .semibold, color: .black)
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .padding(.trailing, 15)
                            VStack {
                                Text(currentQuestion)
                                    .textStyle(font: .largeTitle, weight: .black, color: .black)
                                
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
                                    VStack { }
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
                        .textStyle(font: .title, weight: .bold, color: .custom)
                        .padding(.top, -60)
                }
                
                KeyboardView(game: game)
                
                HStack {
                    Spacer()
                    Button {
                        checkNextQuestion()
                    } label: {
                        SFSymbol(name: "arrow.right", font: (.system(.headline, design: .rounded, weight: .heavy)))
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
            .navigationTitleFont()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        ifEndGame = true
                    } label: {
                        SFSymbol(name: "house.circle.fill")
                    }
                    .alert("End Game", isPresented: $ifEndGame) {
                        Button("Cancel", role: .cancel) { }
                        Button("End Game", role: .destructive) {
                            if !game.currentGame.isEmpty {
                                game.currentGame.removeFirst()
                            }
                            navigateToStartView = true
                        }
                    } message: {
                        Text("Are you sure you want to end your game?")
                    }
                }
            }
            .onAppear {
                getQuestions()
            }
            .navigationDestination(isPresented: $navigateToGameOver) {
                GameOverView(game: game)
            }
            .navigationDestination(isPresented: $navigateToStartView) {
                StartView()
            }
        }
    }
    
    func getQuestions() {
        var rangeBounds = 0...0
        
        if game.settings.num1 > game.settings.num2 {
            rangeBounds = (game.settings.num2...game.settings.num1)
        } else {
            rangeBounds = (game.settings.num1...game.settings.num2)
        }
        
        for _ in 1...game.settings.numOfQuestions {
            let rangePair = [Int.random(in: rangeBounds), Int.random(in: rangeBounds)]
            
            let question = "\(rangePair[0]) x \(rangePair[1])"
            let answer = rangePair.reduce(1, *)
            
            let item = Question(text: question, answer: answer)
            game.questions.append(item)
            
            let equation = QuestionReview(question: question, answer: answer)
            game.questionReview.append(equation)
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
            ifRightAnswer = true
            ifRightAnswerIcon = "checkmark.circle.fill"
        } else {
            score += 0
            ifRightAnswer = false
            ifRightAnswerIcon = "xmark.circle.fill"
        }
        
        if questionNumber + 1 < game.settings.numOfQuestions {
            loadQuestions()
            game.keyboard.removeAll()
        } else {
            let stats = CurrentGame(score: score, category: "multiplication", numOfQuestions: game.settings.numOfQuestions, rightAnswers: score)
            game.currentGame.append(stats)
            navigateToGameOver = true
        }
        
        let check = CheckReview(userAnswer: value, ifRight: ifRightAnswer, checkmarkIcon: ifRightAnswerIcon)
        game.checkReview.append(check)
    }
}

#Preview {
    GameView(game: Game())
}
