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
    
    var moves = ["🪨", "📄", "✂️"]
    var winMoves = ["📄", "✂️", "🪨"]
    
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
                    Text("App choice: \(moves[appChoice])")
                    let _ = print("AC: \(appChoice)")
                    Text("If win or lose: \(shouldWin)")
                    
                    HStack(spacing: 15) {
                        ForEach(0..<3) { item in
                            Button {
                                winOrLose(item)
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
                Spacer()
                Spacer()
                Spacer()
            }
        }
    }
    
    func winOrLose(_ tapped: Int) {
        print("Tapped: \(tapped)")
        
        if shouldWin == true {
            if appChoice == tapped {
                print("Correct choice!")
            } else {
                print("Wrong choice!")
            }
        } else {
            if appChoice != tapped {
                print("Correct choice!")
            } else {
                print("Wrong choice!")
            }
        }
    }
    
    func resetChoice() {
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
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
