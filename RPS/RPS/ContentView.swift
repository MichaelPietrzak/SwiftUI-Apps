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
                    HStack(spacing: 15) {
                        ForEach(0..<3) { item in
                            Button {
                            } label: {
                                Text(moves[item])
                                    .shadowStyle()
                            }
                        }
                    }
                }
                Spacer()
                Spacer()
                Spacer()
            }
        }
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
