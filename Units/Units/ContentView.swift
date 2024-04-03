//
//  ContentView.swift
//  Units
//
//  Created by Michal Pietrzak on 02/04/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Form {
            }
            .navigationTitle("Temperature conversion")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
