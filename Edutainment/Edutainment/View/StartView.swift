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
                    .textStyle(font: .headline, weight: .semibold, color: .secondary)
                    .padding(.bottom, 40)
                
                VStack(spacing: 30) {
                    ZStack {
                        SFSymbol(name: "multiply", font: .system(size: 270).weight(.heavy), primaryColor: .primary)
                            .layoutPriority(-1)
                        
                        VStack {
                            Text("Multiplication")
                                .textStyle(font: .title, weight: .heavy, color: .black)
                                .padding(.top, 30)
                            
                            NavigationLink {
                                GameView(game: game)
                            } label: {
                                Text("Play")
                                    .textStyle(font: .headline, weight: .semibold, color: .orange)
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
                        SFSymbol(name: "trophy.fill", font: .headline, primaryColor: .yellow)
                        Text("\(game.scoreboard.scores)")
                            .textStyle(font: .headline, weight: .semibold, color: .custom)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showScoreboard = true
                    } label: {
                        SFSymbol(name: "list.clipboard.fill")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        SFSymbol(name: "gearshape.circle.fill")
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
