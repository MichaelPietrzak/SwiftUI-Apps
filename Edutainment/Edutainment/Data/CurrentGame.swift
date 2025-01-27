//
//  CurrentGame.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 27/01/2025.
//

import Foundation

struct CurrentGame {
    var score: Int
    var category: String
    var numOfQuestions: Int
    var rightAnswers: Int
    var time: String
    
    static var mockData: [CurrentGame] {
        [CurrentGame(score: 0, category: "unknown", numOfQuestions: 0, rightAnswers: 0, time: "0:00")]
    }
}
