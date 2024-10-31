//
//  ContentView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 29/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedNum1 = 0
    @State private var selectedNum2 = 0
    @State private var selectedNumOfQuestions = 5
    @State private var equation = "0 x 0"
    
    let rangeOfQuestions = [5, 10, 20]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select 2 numbers for difficulty range") {
                    Stepper("\(selectedNum1)", value: $selectedNum1)
                        .font(.headline).fontWeight(.bold)
                    
                    Stepper("\(selectedNum2)", value: $selectedNum2)
                        .font(.headline).fontWeight(.bold)
                }
                
                Section("Select number of questions to be asked") {
                    Picker("numbers of questions", selection: $selectedNumOfQuestions) {
                        ForEach(rangeOfQuestions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("What is...?") {
                    Text(equation)
                        .font(.headline).fontWeight(.bold)
                }
                
                Section("Please enter the answer") {
                    
                }
                
                Button("Check", action: getRandomEquation)
                    .buttonStyle(.bordered)
            }
            .navigationTitle("Edutainment")
        }
    }
    
    func getRandomEquation() {
        var rangeBounds = 0...0
        
        if selectedNum1 > selectedNum2 {
            rangeBounds = (selectedNum2...selectedNum1)
        } else {
            rangeBounds = (selectedNum1...selectedNum2)
        }
        
        let randomNum1 = rangeBounds.randomElement() ?? 0
        let randomNum2 = rangeBounds.randomElement() ?? 0
        
        equation = "\(randomNum1) x \(randomNum2)"
    }
}

#Preview {
    ContentView()
}
