//
//  StartView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 30/12/2024.
//

import SwiftUI

struct StartView: View {
    @State private var showSettings = false
    
    var game: Game
    
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.8196, blue: 0.5804)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    VStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "list.star")
                        }
                    }
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.black)
                    .font(.largeTitle.weight(.heavy))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    
                    Spacer()
                    
                    VStack {
                        Button {
                            showSettings = true
                        } label: {
                            Image(systemName: "gearshape")
                        }
                    }
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.black)
                    .font(.largeTitle.weight(.heavy))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    .sheet(isPresented: $showSettings) {
                        SettingsView(game: game)
                    }
                }
                .padding()
                
                Spacer()
                
                VStack(spacing: 15) {
                    Text("Edutainment")
                        .foregroundStyle(.black)
                        .font(.largeTitle.weight(.heavy))
                    Text("Let's do some math!")
                        .foregroundStyle(Color(red: 0.2, green: 0.0314, blue: 0.4039))
                        .font(.title.weight(.bold))
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Press below to play")
                        .foregroundStyle(.black)
                        .font(.caption.weight(.bold))
                    
                    VStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "play")
                        }
                    }
                    .frame(width: 200, height: 70)
                    .foregroundStyle(.black)
                    .font(.largeTitle.weight(.heavy))
                    .background(.green.opacity(0.7))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    
                    VStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                        }
                    }
                    .frame(width: 200, height: 70)
                    .foregroundStyle(.black)
                    .font(.largeTitle.weight(.heavy))
                    .background(.red.opacity(0.7))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                    })
                    .padding(.bottom, 100)
                }
                .padding()
            }
        }
    }
}

#Preview {
    StartView(game: Game())
}
