//
//  SettingsView.swift
//  FastFlagger
//
//  Created by SunnyFlops on 07/09/2024.
//

import SwiftUI

struct SettingsView: View {    
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Created by SunnyFlops")
            Text("Not intended for commercial or destructive use")
            Button("Disable All Flags") {
                
            }
            Button("Support") {
                @Environment(\.openURL) var openURL
                
                if let url = URL(string: "https://discord.com/invite/XQ3wJh3tXw") {
                    openURL(url)
                }
            }
        }.padding()
    }
}

#Preview {
    SettingsView()
}
