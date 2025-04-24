//
//  StartView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 30/12/2024.
//

import SwiftUI

struct StartView: View {
    @State private var showSettings = false
    @State private var showScoreboard = false
    @StateObject private var game = Game()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Let's do some math, improve your skills")
                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 40)
                
                VStack(spacing: 30) {
                    ZStack {
                        Image(systemName: "multiply")
                            .font(.system(size: 270).weight(.heavy))
                            .foregroundStyle(.primary)
                            .layoutPriority(-1)
                        
                        VStack {
                            Text("Multiplication")
                                .foregroundStyle(.black)
                                .font((.system(.title, design: .rounded, weight: .heavy)))
                                .padding(.top, 30)
                            
                            NavigationLink {
                                GameView(game: game)
                            } label: {
                                Text("Play")
                                    .font((.system(.headline, design: .rounded, weight: .semibold)))
                                    .foregroundStyle(.orange)
                            }
                            .frame(maxWidth: 100, maxHeight: 40)
                            .background(.black)
                            .clipShape(.rect(cornerRadius: 20))
                        }
                        .frame(maxWidth: .infinity, maxHeight: 150)
                        .background(.orange.opacity(0.8))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                    .clipped()
                    .shadow(radius: 10)
                }
                Spacer()
            }
            .padding(.top, -15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Hi, \(game.settings.displayName)!")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .navigationTitleFont()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "trophy.fill")
                            .foregroundStyle(.yellow)
                            .font(.headline)
                        Text("\(game.scoreboard.scores)")
                            .foregroundStyle(.custom)
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showScoreboard = true
                    } label: {
                        Image(systemName: "list.clipboard.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, .primary.opacity(0.2))
                            .imageScale(.large)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.circle.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, .primary.opacity(0.2))
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView(game: game)
            }
            .sheet(isPresented: $showScoreboard) {
                ScoreboardView(game: game)
            }
        }
    }
}

#Preview {
    StartView()
}
