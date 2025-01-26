//
//  Settings.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 08/12/2024.
//

import Foundation

struct Settings {
    var num1: Int
    var num2: Int
    var numOfQuestions: Int
    
    static var mockData: [Settings] {
        [Settings(num1: 0, num2: 0, numOfQuestions: 0)]
    }
}
