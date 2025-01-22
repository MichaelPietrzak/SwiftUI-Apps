//
//  GameReviewView.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 14/01/2025.
//

import SwiftUI

struct GameReviewView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    HStack {
                        Text("4 x 8")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("=")
                            .frame(width: 30)
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Text("32")
                            .frame(width: 30)
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.orange)
                        Text("")
                            .frame(width: 30)
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.green, .green.opacity(0.2))
                            .imageScale(.medium)
                    }
                    .listRowBackground(Color.orange.opacity(0.0))
                    
                    HStack {
                        Text("3 x 10")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("=")
                            .frame(width: 30)
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Text("6")
                            .frame(width: 30)
                            .strikethrough(true, pattern: .dash, color: .red)
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.orange)
                        Text("30")
                            .frame(width: 30)
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.green)
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.red, .red.opacity(0.2))
                            .imageScale(.medium)
                    }
                    .listRowBackground(Color.yellow.opacity(0.0))
                    
                    HStack {
                        Text("2 x 1")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("=")
                            .frame(width: 30)
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Text("2")
                            .frame(width: 30)
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.orange)
                        Text("")
                            .frame(width: 30)
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.green, .green.opacity(0.2))
                            .imageScale(.medium)
                    }
                    .listRowBackground(Color.yellow.opacity(0.0))
                    
                    HStack {
                        Text("5 x 1")
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("=")
                            .frame(width: 30)
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                            .foregroundStyle(.primary)
                        Text("1")
                            .frame(width: 30)
                            .strikethrough(true, pattern: .dash, color: .red)
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.orange)
                        Text("5")
                            .frame(width: 30)
                            .font((.system(.headline, design: .rounded, weight: .heavy)))
                            .foregroundStyle(.green)
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2.weight(.heavy))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.red, .red.opacity(0.2))
                            .imageScale(.medium)
                    }
                    .listRowBackground(Color.yellow.opacity(0.0))
                }
                .frame(maxHeight: .infinity)
                .padding(.top, -30)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10]))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(.orange.opacity(0.2))
                        .padding(.top, -5)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Review")
            .navigationBarTitleDisplayMode(.inline)
            .navigationAppearance()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Close", systemImage: "square.and.arrow.down")
                            .labelStyle(.titleOnly)
                            .font((.system(.headline, design: .rounded, weight: .semibold)))
                    }
                }
            }
        }
    }
}

#Preview {
    GameReviewView()
}

