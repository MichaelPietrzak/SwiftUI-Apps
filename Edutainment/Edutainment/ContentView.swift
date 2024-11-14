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
    @State private var questionAnswer = 0
    @State private var questionNumber = 0
    @State private var questions = [String]()
    
    let rangeOfQuestions = [5, 10, 20]
    
    var body: some View {
        NavigationStack {
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
                    TextField("Enter number", value: $userAnswer, format: .number)
                        .keyboardType(.numberPad)
                } header: {
                    Text("Please enter the answer")
                } footer: {
                    Text(answerStatus)
                }
                
                Button("Next Question") {
                    nextQuestion()
                }
                .buttonStyle(.bordered)
                
                Button("Check Answer") {
                    checkAnswer()
                }
                .buttonStyle(.bordered)
                
                Button("Start Game") {
                    getQuestions()
                }
                .buttonStyle(.bordered)
            }
            .navigationTitle("Edutainment")
            .bold()
        }
    }
    
    func getQuestions() {
        var rangeBounds = 0...0
        var question = ""
        
        if selectedNum1 > selectedNum2 {
            rangeBounds = (selectedNum2...selectedNum1)
        } else {
            rangeBounds = (selectedNum1...selectedNum2)
        }
        
        for _ in 1...selectedNumOfQuestions {
            question = "\(Int.random(in: rangeBounds)) x \(Int.random(in: rangeBounds))"
            questions.append(question)
        }
        loadQuestions()
    }
    
    func loadQuestions() {
        if currentQuestion.isEmpty {
            userAnswer = 0
            answerStatus = ""
            currentQuestion = questions.first ?? "No question"
        } else {
            questionNumber += 1
            userAnswer = 0
            answerStatus = ""
            currentQuestion = questions[questionNumber]
        }
    }
    
    func nextQuestion() {
        if questionNumber + 1 < selectedNumOfQuestions {
            loadQuestions()
        } else {
            // TODO: - add resetGame() method
        }
    }
    
    func getQuestionAnswer() {
        let extractNums = questions.compactMap { $0.compactMap { Int(String($0)) } }
        questionAnswer = extractNums[questionNumber].reduce(1, *)
    }
    
    func checkAnswer() {
        getQuestionAnswer()
        
        if userAnswer == questionAnswer {
            answerStatus = "Correct!"
        } else {
            answerStatus = "Wrong!"
        }
    }
    
}

#Preview {
    ContentView()
}
