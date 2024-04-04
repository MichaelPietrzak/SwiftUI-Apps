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
    
    var unitName: MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        return formatter
    }
    
    var convertTo: String {
        let input = Measurement(value: Double(checkTemperature), unit: inputUnit)
        let output = input.converted(to: outputUnit)
        let roundValue = output.value.formatted(.number.precision(.fractionLength(0)))
        let unit = unitName.string(from: outputUnit)
        return "\(roundValue) \(unit)"
    }
    
    let unitType = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Temperature") {
                    TextField("Enter temperature", value: $checkTemperature, format: .number)
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(unitType, id: \.self) {
                            Text(unitName.string(from: $0))
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Convert to") {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(unitType, id: \.self) {
                            Text(unitName.string(from: $0))
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Result") {
                    Text(convertTo)
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
