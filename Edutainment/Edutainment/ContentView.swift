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
    @State private var ifButtonDisabled = false
    @State private var ifGameActive = false
    @State private var score = 0
    @State private var showScore = false
    @State private var showFinalScore = false
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
            VStack {
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
                                Text("\(selectedNumOfQuestions)")
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
                        GameButton(title: "Check Answer", icon: "checkmark.circle", color: ifGameActive ? .yellow : .gray, ifDisabled: !ifGameActive) { checkAnswer() }
                        GameButton(title: "Next Question", icon: "arrow.right", color: ifGameActive ? .blue : .gray, ifDisabled: !ifGameActive) { nextQuestion() }
                    }
                    GameButton(title: "New Game", icon: "gamecontroller", color: ifButtonDisabled ? .purple : .gray, ifDisabled: !ifButtonDisabled) { newGame() }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
            }
            .navigationTitle("Edutainment")
            .navigationBarTitleDisplayMode(.large)
            .bold()
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
            let rangePair = [Int.random(in: rangeBounds), Int.random(in: rangeBounds)]
            
            let question = "\(rangePair[0]) x \(rangePair[1])"
            let answer = rangePair.reduce(1, *)
            
            let item = Question(text: question, answer: answer)
            questions.append(item)
        }
        withAnimation {
            showScore = true
            ifGameActive = true
            ifButtonDisabled = true
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
            withAnimation {
                gameFocused = false
                showFinalScore = true
                ifButtonDisabled = true
                
                if showFinalScore == true {
                    ifGameActive = false
                }
            }
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
    
    func newGame() {
        selectedNum1 = 0
        selectedNum2 = 0
        selectedNumOfQuestions = 5
        currentQuestion = ""
        userAnswer = 0
        answerStatus = ""
        score = 0
        questionNumber = 0
        questions.removeAll()
        
        withAnimation {
            gameFocused = false
            showScore = false
            showFinalScore = false
            ifCorrectColor = false
            ifButtonDisabled = false
            ifGameActive = false
        }
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
    var ifDisabled: Bool
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
        .disabled(ifDisabled)
    }
}
