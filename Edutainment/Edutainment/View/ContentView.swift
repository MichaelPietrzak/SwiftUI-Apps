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
                
                HStack(spacing: 10) {
                    VStack {
                        Button {
                            newGame()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                        }
                    }
                    .frame(minWidth: 135, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .foregroundStyle(.black)
                    .font(.system(size: 50).weight(.heavy))
                    .background(.red)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    .offset(y: -10)
                    
                    VStack {
                        Text("Multiply")
                            .padding(.top, 50)
                    }
                    .frame(minWidth: 135, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .foregroundStyle(.black)
                    .font(.title.weight(.heavy))
                    .offset(y: -10)
                    
                    VStack {
                        Button {
                            showSettings = true
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                    .frame(minWidth: 135, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .foregroundStyle(.black)
                    .font(.system(size: 50).weight(.heavy))
                    .background(.purple)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    .offset(y: -10)
                    .sheet(isPresented: $showSettings) {
                        SettingsView(game: game)
                    }
                }
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                .padding(.bottom, 50)
                .offset(y: -5)
                
                HStack {
                    Text(currentQuestion)
                    Text("=")
                    Text("?")
                }
                .padding(.bottom, 50)
                .foregroundStyle(.white)
                .font(.system(size: 70).weight(.heavy))
                
                HStack(spacing: 50) {
                    VStack {
                        
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
                                        .font(.system(size: 60).weight(.heavy))
                                }
                            }
                        }
                        .foregroundStyle(.yellow)
                        .font(.system(size: 65).weight(.heavy))
                    }
                    
                    
                    ZStack(alignment: .bottom) {
                        
                        VStack {
                            Image(systemName: "medal.star")
                                .foregroundStyle(.yellow)
                                .font(.system(size: 40).weight(.heavy))
                                .padding(.bottom, 10)
                            
                            Rectangle()
                                .frame(width: 50, height: 200)
                                .opacity(0.3)
                                .foregroundColor(.clear)
                                .background(.gray.secondary)
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 5)
                                })
                        }
                            
                            Rectangle()
                                .frame(width: 45, height: (200 / 10) + 100)
                                .foregroundColor(.clear)
                                .background(LinearGradient(gradient: Gradient(colors: [
                                    Color(red: 1.0, green: 0.4588, blue: 0.549),
                                    Color(red: 1.0, green: 0.4941, blue: 0.702),
                                    Color(red: 1.0, green: 0.4588, blue: 0.549)
                                    ]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(.rect(cornerRadius: 10))
                    }
                }
                
                HStack(spacing: 10) {
                    VStack {
                        Button {
                            getQuestions()
                        } label: {
                            Image(systemName: "arrowtriangle.forward.fill")
                        }
                    }
                    .frame(minWidth: 135, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .foregroundStyle(.black)
                    .font(.system(size: 50).weight(.heavy))
                    .background(.green)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    
                    VStack {
                        Button {
                            checkAnswer()
                        } label: {
                            Image(systemName: "checkmark.circle.badge.questionmark.fill")
                        }
                    }
                    .frame(minWidth: 135, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .foregroundStyle(.black)
                    .font(.system(size: 50).weight(.heavy))
                    .background(.yellow)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    
                    VStack {
                        Button {
                            nextQuestion()
                        } label: {
                            Image(systemName: "arrowshape.forward.fill")
                        }
                    }
                    .frame(minWidth: 135, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .foregroundStyle(.black)
                    .font(.system(size: 50).weight(.heavy))
                    .background(.blue)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                }
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                .padding(.top, 50)
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
            currentQuestion = game.questions.first?.text ?? "0 x 0"
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
