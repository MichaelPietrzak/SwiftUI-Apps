//
//  KeyboardView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 16/12/2024.
//

import SwiftUI

struct KeyboardView: View {
    var keys = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"], ["minus", "0", "arrow.backward"]]
    
    @State private var keysPressed = ""
    
    var game: Game
    
    var body: some View {
        VStack(spacing: -5) {
            ForEach(keys, id: \.self) { row in
                HStack(spacing: -5) {
                    ForEach(row, id: \.self) { column in
                        Button {
                            getkey(column)
                        } label: {
                            Image(systemName: keyIcon(column))
                        }
                    }
                }
                .foregroundStyle(.yellow)
                .font(.system(size: 65).weight(.heavy))
            }
        }
    }
    
    func getkey(_ key: String) {
        let items = Keyboard(key: key)
        game.keyboard.append(items)
        
        _ = game.keyboard.map { item in
            if item.key == "arrow.backward" {
                game.keyboard.removeAll { $0.key == "arrow.backward" }
                
                if game.keyboard.count < 1 {
                    game.keyboard.insert(Keyboard(key: "0"), at: 0)
                } else {
                    game.keyboard.removeLast()
                }
            } else if item.key == "minus" {
                game.keyboard.removeAll { $0.key == "minus" }
                game.keyboard.insert(Keyboard(key: "-"), at: 0)
            }
        }
        if game.keyboard.first?.key == "0" {
            game.keyboard.removeAll { $0.key == "0" }
        }
        
        if game.keyboard.isEmpty {
            game.keyboard.append(Keyboard(key: "0"))
        }
        
        let negativeValue = game.keyboard.filter({ $0.key == "-" }).count > 1
        
        if negativeValue == true {
            game.keyboard.removeAll { $0.key == "-" }
        }
    }
    
    func keyIcon(_ key: String) -> String {
        switch key {
        case "minus":
            "plus.forwardslash.minus"
        case "arrow.backward":
            "arrow.backward.square.fill"
        default:
            "\(key).square.fill"
        }
    }
}

#Preview {
    KeyboardView(game: Game())
}
