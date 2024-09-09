//
//  FastFlaggerApp.swift
//  FastFlagger
//
//  Created by SunnyFlops on 07/09/2024.
//

import SwiftUI

@main
struct FastFlaggerApp: App {
    var vc1 = ContentView()
    var vc2 = AddFlagView()
    
    var body: some Scene {
        WindowGroup(id: "content") {
            ContentView()
        }
        
        WindowGroup(id: "addflag") {
            AddFlagView()
        }.defaultSize(width: 450, height: 250)
        
        WindowGroup(id: "settings") {
            SettingsView()
        }.defaultSize(width: 350, height: 150)
        
        Settings {
            SettingsView()
        }
    }
}
