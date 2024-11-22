//
//  ContentView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 29/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedNum1 = 0
    @State private var selectedNum2 = 0
    @State private var selectedNumOfQuestions = 5
    @State private var currentQuestion = ""
    @State private var userAnswer = 0
    @State private var answerStatus = ""
    @State private var ifCorrectColor = false
    @State private var score = 0
    @State private var showScore = false
    @State private var questionNumber = 0
    @State private var questions = [Question]()
    
    @FocusState private var gameFocused: Bool
    
    let rangeOfQuestions = [5, 10, 20]
    
    var answerInputFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            if showScore {
                HStack {
                    Spacer()
                    
                    Text("Score:")
                    
                    HStack {
                        Text("\(score)")
                            .foregroundStyle(.blue)
                        
                        Text("/")
                        
                        Text("\(selectedNumOfQuestions)")
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .font(.headline.weight(.heavy))
                .foregroundStyle(.primary)
            }
            
            Form {
                Section("Select 2 numbers for difficulty range") {
                    Stepper("\(selectedNum1)", value: $selectedNum1)
                    
                    Stepper("\(selectedNum2)", value: $selectedNum2)
                }
                
                Section("Select number of questions to be asked") {
                    Picker("numbers of questions", selection: $selectedNumOfQuestions) {
                        ForEach(rangeOfQuestions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("What is...?") {
                    Text(currentQuestion)
                }
                
                Section {
                    TextField("Enter number", value: $userAnswer, formatter: answerInputFormatter)
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
            .navigationTitle("Edutainment")
            .bold()
            
            VStack(spacing: 15) {
                GameButton(title: "Start Game", icon: "arcade.stick", color: .green) {
                    withAnimation {
                        showScore = true
                    }
                    getQuestions()
                }
                
                HStack {
                    GameButton(title: "Check Answer", icon: "checkmark.circle", color: .yellow) { checkAnswer() }
                    
                    GameButton(title: "Next Question", icon: "arrow.right", color: .blue) { nextQuestion() }
                }
                GameButton(title: "Reset Game", icon: "xmark.circle", color: .red) {
                    withAnimation {
                        gameFocused = false
                        showScore = false
                    }
                    resetGame()
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
    }
    
    func getQuestions() {
        var rangeBounds = 0...0
        
        if selectedNum1 > selectedNum2 {
            rangeBounds = (selectedNum2...selectedNum1)
        } else {
            rangeBounds = (selectedNum1...selectedNum2)
        }
        
        for _ in 1...selectedNumOfQuestions {
            let question = "\(Int.random(in: rangeBounds)) x \(Int.random(in: rangeBounds))"
            let answer = question.compactMap { $0 }.compactMap { Int(String($0)) }.reduce(1, *)
            
            let item = Question(text: question, answer: answer)
            questions.append(item)
        }
        loadQuestions()
    }
    
    func loadQuestions() {
        if currentQuestion.isEmpty {
            userAnswer = 0
            answerStatus = ""
            currentQuestion = questions.first?.text ?? "No question"
        } else {
            questionNumber += 1
            userAnswer = 0
            answerStatus = ""
            currentQuestion = questions[questionNumber].text
        }
    }
    
    func nextQuestion() {
        if questionNumber + 1 < selectedNumOfQuestions {
            loadQuestions()
        } else {
            resetGame()
        }
    }
    
    func checkAnswer() {
        if userAnswer == questions[questionNumber].answer {
            answerStatus = "Correct!"
            ifCorrectColor = true
            score += 1
        } else {
            answerStatus = "Wrong!"
            ifCorrectColor = false
        }
    }
    
    func resetGame() {
        selectedNum1 = 0
        selectedNum2 = 0
        selectedNumOfQuestions = 5
        currentQuestion = ""
        userAnswer = 0
        answerStatus = ""
        ifCorrectColor = false
        score = 0
        questionNumber = 0
        questions.removeAll()
    }
}

#Preview {
    ContentView()
}

struct Question {
    var text: String
    var answer: Int
}

struct GameButton: View {
    var title: String
    var icon: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(title, systemImage: icon) {
            action()
        }
        .font(.headline.weight(.heavy))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .foregroundStyle(color)
        .background(color.opacity(0.2))
        .clipShape(.rect(cornerRadius: 10))
    }
}
