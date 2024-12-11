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
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 0.149, green: 0.4588, blue: 0.9882),
                Color(red: 0.4157, green: 0.0667, blue: 0.7961)
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                        
                    }
                    .padding(.top, 50)
                    .frame(width: 80, height: 120)
                    .background(.red)
                    .foregroundStyle(.black)
                    .font(.largeTitle.weight(.heavy))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    .offset(y: -10)
                    
                    Spacer()
                    
                    VStack() {
                        Text("Multiply")
                    }
                    .padding(.top, 50)
                    .frame(width: 180, height: 120)
                    .background(.gray.secondary)
                    .foregroundStyle(.black)
                    .font(.title.weight(.heavy))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    .offset(y: -10)
                    
                    Spacer()
                    
                    VStack() {
                        HStack(spacing: 3) {
                            Text("0")
                                .foregroundStyle(.white)
                            Text("/")
                            Text("5")
                        }
                    }
                    .padding(.top, 50)
                    .frame(width: 80, height: 120)
                    .background(.gray.secondary)
                    .foregroundStyle(.black)
                    .font(.title.weight(.heavy))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    .offset(y: -10)
                    
                    Spacer()
                }
                
                HStack {
                    Text("7 x 8")
                    Text("=")
                    Text("?")
                }
                .padding(.vertical, 50)
                .foregroundStyle(.white)
                .font(.system(size: 70).weight(.heavy))
                
                VStack(spacing: -5) {
                    HStack(spacing: -10) {
                        Button {
                            
                        } label: {
                            Image(systemName: "1.square.fill")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "2.square.fill")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "3.square.fill")
                        }
                    }
                    
                    HStack(spacing: -10) {
                        Button {
                            
                        } label: {
                            Image(systemName: "4.square.fill")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "5.square.fill")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "6.square.fill")
                        }
                    }
                    
                    HStack(spacing: -10) {
                        Button {
                            
                        } label: {
                            Image(systemName: "7.square.fill")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "8.square.fill")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "9.square.fill")
                        }
                    }
                    
                    HStack(spacing: -10) {
                        Button {
                            
                        } label: {
                            Image(systemName: "minus.square.fill")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "0.square.fill")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "delete.backward.fill")
                                .font(.system(size: 75).weight(.heavy))
                        }
                    }
                }
                .foregroundStyle(.yellow)
                .font(.system(size: 80).weight(.heavy))
                
                Spacer()
                
                HStack(spacing: 10) {
                    VStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "arrowtriangle.forward.fill")
                        }
                    }
                    .frame(minWidth: 135, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .foregroundStyle(.black)
                    .font(.system(size: 70).weight(.heavy))
                    .background(.green)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    
                    VStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark.circle.badge.questionmark.fill")
                        }
                    }
                    .frame(minWidth: 135, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .foregroundStyle(.black)
                    .font(.system(size: 70).weight(.heavy))
                    .background(.yellow)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    
                    VStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "arrowshape.forward.fill")
                        }
                    }
                    .frame(minWidth: 135, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .foregroundStyle(.black)
                    .font(.system(size: 70).weight(.heavy))
                    .background(.blue)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                }
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                .padding(.top, 20)
                .offset(y: 5)
            }
            .statusBarHidden()
            .ignoresSafeArea()
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
