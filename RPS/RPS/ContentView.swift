//
//  ContentView.swift
//  RPS
//
//  Created by Michal Pietrzak on 25/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var appPick = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var validatePick = ""
    @State private var validatePickColor = false
    @State private var userMoves = ["📄", "✂️", "🪨"]
    
    var appMoves = ["🪨", "📄", "✂️"]
    
    var winKey = [
        "🪨": "📄",
        "✂️": "🪨",
        "📄": "✂️"
    ]
    
    var loseKey = [
        "🪨": "✂️",
        "✂️": "📄",
        "📄": "🪨"
    ]
    
    var winLose: String {
        shouldWin == true ? "win".uppercased() : "lose".uppercased()
    }
    
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("rock paper scissors").textCase(.uppercase)
                    .font(.title.weight(.black))
                
                Spacer()
                VStack(spacing: 10) {
                    Text("\(appMoves[appPick])")
                        .font(.system(size: 70))
                        .padding(.top, 10)
                    
                    Text(winLose)
                        .foregroundStyle(.white)
                        .font(.system(size: 40).weight(.heavy))
                        .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .background(.orange)
                
                Spacer()
                HStack(spacing: 15) {
                    ForEach(0..<3) { item in
                        Button {
                            moveTapped(item)
                        } label: {
                            Text(userMoves[item])
                                .shadowStyle()
                        }
                    }
                }
                
                Spacer()
                Button("reset") {
                    resetChoice()
                }
                .buttonStyle(.bordered)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(15)
                .font(.title.weight(.black))
                .textCase(.uppercase)
                
                Spacer()
                Text(validatePick)
                    .foregroundStyle(validatePickColor ? .green : .red)
                    .font(.system(size: 30).weight(.heavy))
                
                Spacer()
                Spacer()
                Spacer()
            }
        }
    }
    
    func moveTapped(_ tapped: Int) {
        if shouldWin == true {
            if winKey[appMoves[appPick]]! == userMoves[tapped] {
                validatePick = "You win!".uppercased()
                validatePickColor = true
            } else {
                validatePick = "You lose!".uppercased()
                validatePickColor = false
            }
        } else {
            if loseKey[appMoves[appPick]]! == userMoves[tapped] {
                validatePick = "You win!".uppercased()
                validatePickColor = true
            } else {
                validatePick = "You lose!".uppercased()
                validatePickColor = false
            }
        }
        
        if appMoves[appPick] == userMoves[tapped] {
            validatePick = "lose, same move!".uppercased()
        }
    }
    
    func resetChoice() {
        appPick = Int.random(in: 0...2)
        shouldWin = Bool.random()
        validatePick = ""
        userMoves.shuffle()
    }
}

struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 100)
            .background(.gray.opacity(0.3))
            .cornerRadius(20)
            .shadow(
                color: .gray.opacity(0.4),
                radius: 9,
                x: 0,
                y: 0
            )
            .foregroundStyle(.black)
            .font(.system(size: 70))
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
