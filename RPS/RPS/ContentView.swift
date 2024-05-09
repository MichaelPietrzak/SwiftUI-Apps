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
    @State private var validateColor = Color.yellow
    @State private var userMoves = ["✋🏼", "✌🏼", "👊🏼"]
    
    var validateColors = [Color.yellow, Color.red, Color.green]
    var appMoves = ["👊🏼", "✋🏼", "✌🏼"]
    
    var winKey = [
        "👊🏼": "✋🏼",
        "✌🏼": "👊🏼",
        "✋🏼": "✌🏼"
    ]
    
    var loseKey = [
        "👊🏼": "✌🏼",
        "✌🏼": "✋🏼",
        "✋🏼": "👊🏼"
    ]
    
    var winLose: String {
        shouldWin == true ? "win".uppercased() : "lose".uppercased()
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("rock paper scissors").textCase(.uppercase)
                    .font(.title.weight(.black))
                
                Spacer()
                Spacer()
                Text("tap right move to ...").textCase(.uppercase)
                    .font(.title2.weight(.black))
                
                HStack(alignment: .center, spacing: 30) {
                    Text("\(appMoves[appPick])")
                        .font(.system(size: 70))
                    
                    Text(winLose)
                        .foregroundStyle(.white)
                    .font(.system(size: 70)).fontWeight(.black)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(.orange)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
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
                .cornerRadius(20)
                .font(.title.weight(.black))
                .textCase(.uppercase)
                
                Spacer()
                VStack {
                    Text(validatePick)
                        .foregroundStyle(.white)
                        .font(.system(size: 30).weight(.heavy))
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .background(.black)
                .cornerRadius(20)
            }
            .padding()
            .background(validateColor)
        }
    }
    
    func moveTapped(_ tapped: Int) {
        if shouldWin == true {
            if winKey[appMoves[appPick]]! == userMoves[tapped] {
                validatePick = "You win!".uppercased()
                validateColor = validateColors[2]
            } else {
                validatePick = "You lose!".uppercased()
                validateColor = validateColors[1]
            }
        } else {
            if loseKey[appMoves[appPick]]! == userMoves[tapped] {
                validatePick = "You win!".uppercased()
                validateColor = validateColors[2]
            } else {
                validatePick = "You lose!".uppercased()
                validateColor = validateColors[1]
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
        validateColor = validateColors[0]
    }
}

struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 100)
            .background(.purple)
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
