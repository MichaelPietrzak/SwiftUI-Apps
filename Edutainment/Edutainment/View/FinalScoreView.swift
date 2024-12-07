//
//  FinalScoreView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 08/12/2024.
//

import SwiftUI

struct FinalScoreView: View {
    var score: Int
    var numOfQuestions: Int
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Game Over")
                .font(.title.weight(.black))
                .foregroundStyle(.red)
            HStack {
                Text("You got")
                Text("\(score)")
                    .foregroundStyle(.blue)
                Text("out of")
                Text("\(numOfQuestions)")
                    .foregroundStyle(.blue)
                Text("points.")
            }
            .font(.headline.weight(.heavy))
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.red, lineWidth: 2)
        }
    }
}

#Preview {
    FinalScoreView(score: 0, numOfQuestions: 5)
}
