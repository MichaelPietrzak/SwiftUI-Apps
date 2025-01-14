//
//  EndOfGameView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 09/01/2025.
//

import SwiftUI

struct GameOverView: View {
    
    var testStats = GameStats(score: 20, category: "multiplication", numOfQuestions: 5, rightAnswers: 4, time: "1:45")
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("You scored ")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.primary)
                +
                Text("\(testStats.score) points")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.orange)
                
                +
                Text(" in ")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.primary)
                +
                Text(testStats.category)
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.orange)
                +
                Text("!")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.primary)
                
                Spacer()
                Text("Let's check how you did below")
                    .font((.system(.subheadline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.secondary)
                
                List {
                    HStack {
                        Text("Questions")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("\(testStats.numOfQuestions)")
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.orange)
                    }
                    .listRowBackground(Color.yellow.opacity(0.0))
                    
                    HStack {
                        Text("Right answers")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("\(testStats.rightAnswers)")
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.orange)
                    }
                    .listRowBackground(Color.yellow.opacity(0.0))
                    
                    HStack {
                        Text("Time")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text(testStats.time)
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
                
                Spacer()
                
                Text("Let's review your answers")
                    .font((.system(.subheadline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.secondary)
                
                List {
                    NavigationLink {
                 
                    } label: {
                        Image(systemName: "list.bullet.circle.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.orange, .black)
                            .imageScale(.large)
                        Text("Review Questions")
                            .foregroundStyle(.black)
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                    }
                    .listRowBackground(Color.orange.opacity(0.8))
                    .foregroundStyle(.white, .black)
                }
                .padding(-20)
                .padding(.top, -15)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                
                HStack {
                    
                    NavigationLink {
                        
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.primary)
                        Text("New Game")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: 200, maxHeight: 40)
                    .background(.blue.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Spacer()
                    
                    NavigationLink {
                        StartView()
                    } label: {
                        Image(systemName: "house.circle.fill")
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.primary)
                        Text("All Games")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: 200, maxHeight: 40)
                    .background(.blue.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 20))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Game Over")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .navigationAppearance()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        StartView()
                    } label: {
                        Image(systemName: "list.clipboard.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, .primary.opacity(0.2))
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

#Preview {
    GameOverView()
}
