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
