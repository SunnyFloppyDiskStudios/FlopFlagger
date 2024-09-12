//
//  ComingSoonView.swift
//  FlopFlagger
//
//  Created by SunnyFlops on 12/09/2024.
//

import SwiftUI

struct ComingSoonView: View {
    var body: some View {
        Image(systemName: "sparkles")
            .imageScale(.large)
            .foregroundStyle(.tint)
        Text("This feature is coming soon!")
    }
}

#Preview {
    ComingSoonView()
}
