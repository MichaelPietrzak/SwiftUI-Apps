//
//  Review.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 14/01/2025.
//

import Foundation

struct QuestionReview: Identifiable {
    var id = UUID()
    var question: String
    var answer: Int
}

struct CheckReview: Identifiable {
    var id = UUID()
    var userAnswer: Int
    var ifRight: Bool
    var checkmarkIcon: String
}
