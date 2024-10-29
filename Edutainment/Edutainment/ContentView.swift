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
                    
                }
                
                Section("What is...?") {
                    
                }
                
                Section("Please enter the answer") {
                    
                }
            }
            .navigationTitle("Edutainment")
        }
    }
}

#Preview {
    ContentView()
}
