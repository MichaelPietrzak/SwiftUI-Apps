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
    @State private var validateColor = false
    @State private var moveCount = 1
    @State private var userScore = 0
    @State private var finalScore = false
    @State private var scoreTitle = ""
    @State private var userMoves = ["✋🏼", "✌🏼", "👊🏼"]
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
                HStack {
                    Text("rock").textCase(.uppercase).foregroundColor(.red)
                    Text("paper").textCase(.uppercase).foregroundColor(.green)
                    Text("scissors").textCase(.uppercase).foregroundColor(.blue)
                }
                .font(.title3.weight(.black))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(.black)
                .clipShape(.rect(cornerRadius: 20))
                .padding()
                
                VStack {
                    Text("tap right move to ...").textCase(.uppercase)
                        .font(.subheadline.weight(.black))
                        .foregroundColor(.white)
                    
                    HStack(alignment: .center, spacing: 30) {
                        Text("\(appMoves[appPick])")
                            .font(.system(size: 50))
                        
                        Text(winLose)
                            .foregroundStyle(.white)
                            .font(.system(size: 50)).fontWeight(.black)
                    }
                    .frame(width: 300)
                    .padding(.vertical, 15)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .background(.black)
                .clipShape(.rect(cornerRadius: 20))
                
                HStack(alignment: .center, spacing: 100) {
                    HStack(spacing: 10) {
                        Text("Score:").textCase(.uppercase)
                            .font(.headline.weight(.heavy))
                            .foregroundColor(.black)
                        
                        Text("\(userScore)")
                            .font(.headline.weight(.black))
                            .foregroundColor(.blue)
                    }
                    
                    HStack(spacing: 10) {
                        Text("Move:").textCase(.uppercase)
                            .font(.headline.weight(.heavy))
                            .foregroundColor(.black)
                        
                        HStack(spacing: 0) {
                            Text("\(moveCount) ")
                                .font(.headline.weight(.black))
                                .foregroundColor(.blue)
                            
                            Text("/ 3")
                                .font(.headline.weight(.heavy))
                                .foregroundColor(.black)
                        }
                    }
                    
                    .alert("Game over", isPresented: $finalScore) {
                        Button("Restart game", action: restartGame)
                    } message: {
                        Text("Final score: \(userScore) points")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                Spacer()
                Text("Win or lose...?").textCase(.uppercase)
                    .font(.subheadline.weight(.black))
                    .foregroundColor(.black)
                
                Text(validatePick)
                    .font(.system(size: 30).weight(.heavy))
                    .foregroundColor(validateColor ? .green : .red)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 20))
                
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
            }
            .padding()
            .background(.yellow)
        }
    }
    
    func moveTapped(_ tapped: Int) {
        if shouldWin == true {
            if winKey[appMoves[appPick]]! == userMoves[tapped] {
                validatePick = "You win!".uppercased()
                validateColor = true
                userScore += 1
            } else {
                validatePick = "You lose!".uppercased()
                validateColor = false
                if userScore <= 0 {
                    userScore = 0
                } else {
                    userScore -= 1
                }
            }
        } else {
            if loseKey[appMoves[appPick]]! == userMoves[tapped] {
                validatePick = "You win!".uppercased()
                validateColor = true
                userScore += 1
            } else {
                validatePick = "You lose!".uppercased()
                validateColor = false
                if userScore <= 0 {
                    userScore = 0
                } else {
                    userScore -= 1
                }
            }
        }
        
        if appMoves[appPick] == userMoves[tapped] {
            validatePick = "lose, same move!".uppercased()
        }
        
        if moveCount == 3 {
            finalScore = true
        } else {
            nextMove()
        }
    }
    
    func nextMove() {
        appPick = Int.random(in: 0...2)
        shouldWin = Bool.random()
        userMoves.shuffle()
        moveCount += 1
    }
    
    func restartGame() {
        validatePick = ""
        moveCount = 1
        userScore = 0
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
