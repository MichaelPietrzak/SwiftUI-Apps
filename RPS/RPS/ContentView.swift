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
                            nextMove()
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
            } else {
                validatePick = "You lose!".uppercased()
                validateColor = false
            }
        } else {
            if loseKey[appMoves[appPick]]! == userMoves[tapped] {
                validatePick = "You win!".uppercased()
                validateColor = true
            } else {
                validatePick = "You lose!".uppercased()
                validateColor = false
            }
        }
        
        if appMoves[appPick] == userMoves[tapped] {
            validatePick = "lose, same move!".uppercased()
        }
    }
    
    func nextMove() {
        appPick = Int.random(in: 0...2)
        shouldWin = Bool.random()
        userMoves.shuffle()
    }
    
    func restartGame() {
        validatePick = ""
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
