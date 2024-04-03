//
//  ContentView.swift
//  Units
//
//  Created by Michal Pietrzak on 02/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkTemperature = 25
    @State private var inputUnit = "Celcius"
    
    let units = ["Celcius", "Fahrenheit", "Kelvin"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Temperature") {
                    TextField("Enter temperature", value: $checkTemperature, format: .number)
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text( "\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
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
