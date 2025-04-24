//
//  NavigationTitleFontModifier.swift
//  Edutainment
//
//  Created by Michal Pietrzak on 24/04/2025.
//

import SwiftUI

struct NavigationTitleFontModifier: ViewModifier {
    init() {
        var largeTitle = UIFont.preferredFont(forTextStyle: .largeTitle)
        var inlineTitle = UIFont.preferredFont(forTextStyle: .body)
        
        largeTitle = UIFont(descriptor: largeTitle.fontDescriptor.withDesign(.rounded)?.withSymbolicTraits(.traitBold) ?? largeTitle.fontDescriptor, size: largeTitle.pointSize)
        inlineTitle = UIFont(descriptor: inlineTitle.fontDescriptor.withDesign(.rounded)?.withSymbolicTraits(.traitBold) ?? inlineTitle.fontDescriptor, size: inlineTitle.pointSize)
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: largeTitle]
        UINavigationBar.appearance().titleTextAttributes = [.font: inlineTitle]
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationTitleFont() -> some View {
        modifier(NavigationTitleFontModifier())
    }
}
