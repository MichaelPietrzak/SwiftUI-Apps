//
//  Game.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 24/04/2025.
//

import Foundation

class Game: ObservableObject {
    @Published var settings: Settings
    @Published var scoreboard: Scoreboard
    
    @Published var keyboard       = [Keyboard]()
    @Published var questions      = [Question]()
    @Published var currentGame    = [CurrentGame]()
    @Published var questionReview = [QuestionReview]()
    @Published var checkReview    = [CheckReview]()
    
    init() {
        settings = Settings(displayName: "", num1: 3, num2: 6, numOfQuestions: 5)
        scoreboard = Scoreboard(scores: 0, questions: 0, rightAnswers: 0)
        currentGame = [CurrentGame(score: 0, category: "unknown", numOfQuestions: 0, rightAnswers: 0)]
        
        savedSettings()
        savedScoreboard()
    }
    
    func savedSettings() {
        if let savedSettings = UserDefaults.standard.data(forKey: "Settings") {
            if let decoded = try? JSONDecoder().decode(Settings.self, from: savedSettings) {
                settings.displayName = decoded.displayName
                settings.num1 = decoded.num1
                settings.num2 = decoded.num2
                settings.numOfQuestions = decoded.numOfQuestions
                return
            }
        }
    }
    
    func saveSettings() {
        let saveSettings = Settings(displayName: settings.displayName, num1: settings.num1, num2: settings.num2, numOfQuestions: settings.numOfQuestions)
        if let encoded = try? JSONEncoder().encode(saveSettings) {
            UserDefaults.standard.set(encoded, forKey: "Settings")
        }
    }
    
    func savedScoreboard() {
        if let savedScoreboard = UserDefaults.standard.data(forKey: "Scoreboard") {
            if let decoded = try? JSONDecoder().decode(Scoreboard.self, from: savedScoreboard) {
                scoreboard.scores = decoded.scores
                scoreboard.questions = decoded.questions
                scoreboard.rightAnswers = decoded.rightAnswers
                return
            }
        }
    }
    
    func saveScoreboard() {
        let saveScoreboard = Scoreboard(scores: scoreboard.scores, questions: scoreboard.questions, rightAnswers: scoreboard.rightAnswers)
        if let encoded = try? JSONEncoder().encode(saveScoreboard) {
            UserDefaults.standard.set(encoded, forKey: "Scoreboard")
        }
    }
}
