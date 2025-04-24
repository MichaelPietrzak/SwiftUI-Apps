//
//  ScoreDetails.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 24/04/2025.
//

import SwiftUI

struct ScoreDetails: View {
    var questions: Int
    var answers: Int
    var bestTime: String
    
    var body: some View {
        Text("Let's check how you did below")
            .font((.system(.subheadline, design: .rounded, weight: .semibold)))
            .foregroundStyle(.secondary)
        
        List {
            HStack {
                Text("Questions")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.primary)
                Spacer()
                Text("\(questions)")
                    .font((.system(.headline, design: .rounded, weight: .heavy)))
                    .foregroundStyle(.orange)
            }
            .listRowBackground(Color.yellow.opacity(0.0))
            
            HStack {
                Text("Right Answers")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.primary)
                Spacer()
                Text("\(answers)")
                    .font((.system(.headline, design: .rounded, weight: .heavy)))
                    .foregroundStyle(.orange)
            }
            .listRowBackground(Color.yellow.opacity(0.0))
            
            HStack {
                Text("Time")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.primary)
                Spacer()
                Text("\(bestTime)")
                    .font((.system(.headline, design: .rounded, weight: .heavy)))
                    .foregroundStyle(.orange)
            }
            .listRowBackground(Color.yellow.opacity(0.0))
        }
        .frame(maxHeight: 180)
        .padding(.top, -30)
        .scrollContentBackground(.hidden)
        .scrollDisabled(true)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10]))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.orange.opacity(0.2))
                .padding(.top, -5)
        }
    }
}

#Preview {
    ScoreDetails(questions: 0, answers: 0, bestTime: "0:00")
}
