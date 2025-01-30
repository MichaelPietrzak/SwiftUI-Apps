//
//  Scoreboard.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 28/01/2025.
//

import Foundation

struct Scoreboard {
    var scores: Int
    var questions: Int
    var rightAnswers: Int
    var bestTime: String
    
    static var mockData: [Scoreboard] {
        [Scoreboard(scores: 0, questions: 0, rightAnswers: 0, bestTime: "0:00")]
    }
}
