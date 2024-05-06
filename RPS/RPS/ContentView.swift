//
//  ContentView.swift
//  RPS
//
//  Created by Michal Pietrzak on 25/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var checkChoice = ""
    
    var moves = ["🪨", "📄", "✂️"]
    var winMoves = ["📄", "✂️", "🪨"]
    
    var winLose: String {
        shouldWin == true ? "Win" : "Lose"
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("RPS Game")
                    .font(.largeTitle.weight(.heavy))
                
                Spacer()
                VStack {
                    Text("\(moves[appChoice])")
                        .font(.system(size: 70))
                    Text(winLose)
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                        
                    HStack(spacing: 15) {
                        ForEach(0..<3) { item in
                            Button {
                                moveTapped(item)
                            } label: {
                                Text(winMoves[item])
                                    .shadowStyle()
                            }
                        }
                    }
                }
                Button("reset") {
                    resetChoice()
                }
                
                Text(checkChoice)
                    .foregroundStyle(.red)
                    .font(.subheadline.weight(.heavy))
                
                Spacer()
                Spacer()
                Spacer()
            }
        }
    }
    
    func moveTapped(_ tapped: Int) {
        if shouldWin == true {
            if appChoice == tapped {
                checkChoice = "Correct"
            } else {
                checkChoice = "Wrong"
            }
        } else {
            if appChoice != tapped {
                checkChoice = "Correct"
            } else {
                checkChoice = "Wrong"
            }
        }
    }
    
    func resetChoice() {
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        checkChoice = ""
    }
}

struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 100)
            .background(.white)
            .cornerRadius(20)
            .shadow(
                color: .gray.opacity(0.4),
                radius: 9,
                x: 0,
                y: 0
            )
            .foregroundStyle(.black)
            .font(.largeTitle)
    }
}

extension View {
    func shadowStyle() -> some View {
        modifier(Shadow())
    }
}

#Preview {
    ContentView()
}
