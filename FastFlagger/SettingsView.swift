//
//  SettingsView.swift
//  FastFlagger
//
//  Created by SunnyFlops on 07/09/2024.
//

import SwiftUI
import SwiftData

var clientVersion: String = "0.0.0"
var studioVersion: String = "0.0.0"

func writeVersions(_ CVU: String, _ SVU: String) {
    clientVersion = CVU
    studioVersion = SVU
}


struct SettingsView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Created by SunnyFlops")
            
            Text("Not intended for commercial or destructive use")
            
            Button("Disable All Flags") {
                activeFlags.removeAll()
            }
            
            Button("Support") {
                @Environment(\.openURL) var openURL
                
                if let url = URL(string: "https://discord.com/invite/XQ3wJh3tXw") {
                    openURL(url)
                }
            }
            
            Button("Clear Flags") {
                flags.removeAll()
                activeFlags.removeAll()
                reloadContentViewAfterDelete()
            }
            
            Text("Client Version: \(clientVersion)")
            Text("Studio Version: \(studioVersion)")
            
        }.padding()
        
    }
}

#Preview {
    SettingsView()
}
