//
//  ContentView.swift
//  Units
//
//  Created by Michal Pietrzak on 02/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkTemperature = 25
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Temperature") {
                    TextField("Enter temperature", value: $checkTemperature, format: .number)
                    Text(checkTemperature, format: .number)
                }
                Section("Input units") {
                    
                }
                Section("Output units") {
                    
                }
                Section("Output") {
                    
                }
            }
            .navigationTitle("Temperature conversion")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
