//
//  ComingSoonView.swift
//  FlopFlagger
//
//  Created by SunnyFlops on 12/09/2024.
//

import SwiftUI

struct CompletedView: View {
    var body: some View {
        Image(systemName: "sparkles")
            .imageScale(.large)
            .foregroundStyle(.tint)
        Text("Success!")
        Button("Dismiss") {
            @Environment(\.dismissWindow) var dismissWindow
            
            dismissWindow(id: "done")
            
        }
    }
}
