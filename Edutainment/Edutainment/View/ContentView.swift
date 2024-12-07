//
//  ContentView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 29/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentQuestion = ""
    @State private var userAnswer = ""
    @State private var answerStatus = ""
    @State private var ifCorrectColor = false
    @State private var ifButtonDisabled = false
    @State private var ifCheckQuestion = false
    @State private var ifNextQuestion = false
    @State private var score = 0
    @State private var showScore = false
    @State private var showFinalScore = false
    @State private var questionNumber = 0
    @State private var showSettings = false
    
    @State private var game = Game()
    
    @FocusState private var gameFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                if showScore {
                    HStack {
                        Spacer()
                        Text("Score:")
                        HStack {
                            Text("\(score)")
                                .foregroundStyle(.blue)
                            Text("/")
                            Text("\(game.settings[0].NumOfQuestions)")
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .font(.headline.weight(.heavy))
                    .foregroundStyle(.primary)
                }
                Form {
                    Section("What is...?") {
                        Text(currentQuestion)
                    }
                    Section {
                        TextField("Enter number", text: $userAnswer)
                            .keyboardType(.numberPad)
                            .focused($gameFocused)
                    } header: {
                        Text("Please enter the answer")
                    } footer: {
                        Text(answerStatus)
                            .foregroundStyle(ifCorrectColor ? .green : .red)
                            .font(.headline.weight(.heavy))
                    }
                }
                VStack(spacing: 15) {
                    if showFinalScore {
                        VStack(spacing: 15) {
                            Text("Game Over")
                                .font(.title.weight(.black))
                                .foregroundStyle(.red)
                            HStack {
                                Text("You got")
                                Text("\(score)")
                                    .foregroundStyle(.blue)
                                Text("out of")
                                Text("\(game.settings[0].NumOfQuestions)")
                                    .foregroundStyle(.blue)
                                Text("points.")
                            }
                            .font(.headline.weight(.heavy))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: 2)
                        }
                    }
                    GameButton(title: "Start Game", icon: "arcade.stick", color: ifButtonDisabled ? .gray : .green, ifDisabled: ifButtonDisabled) { getQuestions() }
                    HStack {
                        GameButton(title: "Check Answer", icon: "checkmark.circle", color: ifCheckQuestion ? .yellow : .gray, ifDisabled: !ifCheckQuestion) { checkAnswer() }
                        GameButton(title: "Next Question", icon: "arrow.right", color: ifNextQuestion ? .blue : .gray, ifDisabled: !ifNextQuestion) { nextQuestion() }
                    }
                    GameButton(title: "New Game", icon: "gamecontroller", color: ifButtonDisabled ? .purple : .gray, ifDisabled: !ifButtonDisabled) { newGame() }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
            }
            .navigationTitle("Edutainment")
            .navigationBarTitleDisplayMode(.large)
            .bold()
            .toolbar {
                Button("Settings", systemImage: "gear") {
                    showSettings = true
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView(game: game)
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
        
        for _ in 1...game.settings[0].NumOfQuestions {
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
            currentQuestion = game.questions.first?.text ?? "No question"
        } else {
            questionNumber += 1
            userAnswer = ""
            answerStatus = ""
            currentQuestion = game.questions[questionNumber].text
        }
    }
    
    func nextQuestion() {
        if questionNumber + 1 < game.settings[0].NumOfQuestions {
            loadQuestions()
            ifNextQuestion = false
            ifCheckQuestion = true
        } else {
            withAnimation {
                gameFocused = false
                showFinalScore = true
                ifButtonDisabled = true
                ifNextQuestion = false
                ifCheckQuestion = false
                
                if showFinalScore == true {
                    ifCheckQuestion = false
                }
            }
        }
    }
    
    func checkAnswer() {
        let value = Int(userAnswer) ?? 0
        
        if value == game.questions[questionNumber].answer {
            answerStatus = "Correct!"
            ifCorrectColor = true
            score += 1
            ifCheckQuestion = false
            ifNextQuestion = true
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
        game.settings[0].NumOfQuestions = 5
        currentQuestion = ""
        userAnswer = ""
        answerStatus = ""
        score = 0
        questionNumber = 0
        game.questions.removeAll()
        
        withAnimation {
            gameFocused = false
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
    ContentView()
}

class Game {
    var settings = [Settings]()
    var questions = [Question]()
}

struct Question {
    var text: String
    var answer: Int
}

struct Settings {
    var num1: Int
    var num2: Int
    var NumOfQuestions: Int
}
