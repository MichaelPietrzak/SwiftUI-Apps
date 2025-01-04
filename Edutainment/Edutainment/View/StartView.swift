//
//  StartView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 30/12/2024.
//

import Observation
import SwiftUI

struct StartView: View {
    @State private var showSettings = false
    @State private var game = Game()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Let's do some math, improve your skills")
                    .font(.subheadline.weight(.semibold))
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
                                .font(.title.weight(.heavy))
                                .padding(.top, 30)
                            
                            NavigationLink {
                                GameView(game: game)
                            } label: {
                                Text("Play")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.yellow)
                            }
                            .frame(maxWidth: 100, maxHeight: 40)
                            .background(.black)
                            .clipShape(.rect(cornerRadius: 20))
                        }
                        .frame(maxWidth: .infinity, maxHeight: 150)
                        .background(.yellow.opacity(0.8))
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
            .navigationTitle("Math Games")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "trophy.fill")
                            .foregroundStyle(.yellow)
                            .font(.headline)
                        Text("38")
                            .foregroundStyle(.custom)
                            .font(.headline.weight(.heavy))
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "list.star")
                            .font(.headline.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.yellow, .custom)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.headline.weight(.heavy))
                            .foregroundStyle(.custom)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView(game: game)
            }
        }
    }
}

#Preview {
    StartView()
}

@Observable
class Game {
    var settings = [Settings]()
    var questions = [Question]()
    var keyboard = [Keyboard]()
}
