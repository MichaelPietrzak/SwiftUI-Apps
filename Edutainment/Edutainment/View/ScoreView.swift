//
//  ScoreView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 08/12/2024.
//

import SwiftUI

struct ScoreView: View {
    var score: Int
    var numOfQuestions: Int

    var body: some View {
        HStack {
            Spacer()
            Text("Score:")
            HStack {
                Text("\(score)")
                    .foregroundStyle(.blue)
                Text("/")
                Text("\(numOfQuestions)")
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .font(.headline.weight(.heavy))
        .foregroundStyle(.primary)
    }
}

#Preview {
    ScoreView(score: 2, numOfQuestions: 5)
}
