//
//  PresetsView.swift
//  FlopFlagger
//
//  Created by Arav Prasad on 21/09/2024.
//

import SwiftUI

struct PresetsView: View {
    var body: some View {
        VStack {
            HStack {
                Button("Create Preset") {
                    
                }.padding()
                
                Spacer()
                
                Button("Get More Presets") {
                    @Environment(\.openURL) var openURL
                    
                    if let url = URL(string: "https://discord.com/invite/XQ3wJh3tXw") {
                        openURL(url)
                    }
                }.padding()
            }
            ScrollView {
                // presets
            }
        }
    }
}
