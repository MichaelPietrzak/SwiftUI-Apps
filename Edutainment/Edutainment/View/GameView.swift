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
    @State private var answerStatus = ""
    @State private var ifCorrectColor = false
    @State private var ifButtonDisabled = false
    @State private var ifCheckQuestion = false
    @State private var ifNextQuestion = false
    @State private var score = 0
    @State private var scoreProgress = 0
    @State private var showScore = false
    @State private var showFinalScore = false
    @State private var questionNumber = 0
    @State private var showSettings = false
    
    @Environment(\.dismiss) var dismiss
    
    var game: Game
    
    var keyboardValue: String {
        game.keyboard.map({ $0.key }).joined()
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 30) {
                VStack(spacing: 5) {
                    ProgressView(value: 0.9)
                        .progressViewStyle(.linear)
                        .tint(.orange)
                    HStack {
                        Spacer()
                        Text("Question")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.secondary)
                        Text("15")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.custom)
                    }
                }
                
                Text("02:30")
                    .font((.system(.title, design: .rounded, weight: .heavy)))
                    .frame(maxWidth: .infinity, maxHeight: 50)
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
                            .padding(.top, -5)
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "trophy.circle.fill")
                                    .font(.title2.weight(.heavy))
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.yellow, .black)
                                    .imageScale(.large)
                                Text("5")
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
                                        .offset(y: 70)
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
                    NavigationLink {
                        GameOverView()
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
                        dismiss()
                    } label: {
                        Image(systemName: "house.circle.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, .primary.opacity(0.2))
                            .imageScale(.large)
                    }
                }
            }
            .onAppear(perform: {
                game.settings.isEmpty ? print("Empty settings") : getQuestions()
            })
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
        
        withAnimation {
            showScore = true
            ifCheckQuestion = true
            ifButtonDisabled = true
        }
    }
    
    func loadQuestions() {
        if currentQuestion.isEmpty {
            userAnswer = ""
            answerStatus = ""
            currentQuestion = game.questions.first?.text ?? "0 x 0"
        } else {
            questionNumber += 1
            userAnswer = ""
            answerStatus = ""
            currentQuestion = game.questions[questionNumber].text
        }
    }
    
    func nextQuestion() {
        if questionNumber + 1 < game.settings[0].numOfQuestions {
            loadQuestions()
            ifNextQuestion = false
            ifCheckQuestion = true
            game.keyboard.removeAll()
        } else {
            withAnimation {
                showFinalScore = true
                ifButtonDisabled = true
                ifNextQuestion = false
                ifCheckQuestion = false
                game.keyboard.removeAll()
                
                if showFinalScore == true {
                    ifCheckQuestion = false
                }
            }
        }
    }
    
    func checkAnswer() {
        userAnswer = keyboardValue
        let value = Int(userAnswer) ?? 0
        
        if value == game.questions[questionNumber].answer {
            answerStatus = "Correct!"
            ifCorrectColor = true
            score += 1
            ifCheckQuestion = false
            ifNextQuestion = true
            
            withAnimation(.spring) {
                scoreProgress = (200 / game.settings[0].numOfQuestions) * score
            }
            
        } else {
            answerStatus = "Wrong!"
            ifCorrectColor = false
            ifCheckQuestion = false
            ifNextQuestion = true
        }
        
        if userAnswer.isEmpty {
            answerStatus = "Please enter number!"
            ifCheckQuestion = true
            ifNextQuestion = false
        }
    }
    
    func newGame() {
        game.settings[0].num1 = 0
        game.settings[0].num2 = 0
        game.settings[0].numOfQuestions = 5
        currentQuestion = ""
        userAnswer = ""
        answerStatus = ""
        score = 0
        scoreProgress = 0
        questionNumber = 0
        game.questions.removeAll()
        game.keyboard.removeAll()
        
        withAnimation {
            showScore = false
            showFinalScore = false
            ifCorrectColor = false
            ifButtonDisabled = false
            ifCheckQuestion = false
            ifNextQuestion = false
        }
    }
}

#Preview {
    GameView(game: Game())
}
