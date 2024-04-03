//
//  ContentView.swift
//  Units
//
//  Created by Michal Pietrzak on 02/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkTemperature = 25
    @State private var inputUnit = UnitTemperature.celsius
    @State private var outputUnit = UnitTemperature.fahrenheit
    
    let unitType = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Temperature") {
                    TextField("Enter temperature", value: $checkTemperature, format: .number)
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(unitType, id: \.self) {
                            Text( "\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Convert to") {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(unitType, id: \.self) {
                            Text( "\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
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
