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
        }.defaultSize(width: 1200, height: 650)
        
        WindowGroup(id: "addflag") {
            AddFlagView()
        }.defaultSize(width: 450, height: 250)
        
        WindowGroup(id: "settings") {
            SettingsView()
        }.defaultSize(width: 375, height: 175)
        
        WindowGroup(id: "comingsoon") {
            ComingSoonView()
        }.defaultSize(width: 150, height: 150)
        
        WindowGroup(id: "done") {
            CompletedView()
        }.defaultSize(width: 150, height: 150)
        
        WindowGroup(id: "presets") {
            PresetsView()
        }.defaultSize(width: 500, height: 600)
        
        WindowGroup(id: "presetNaming") {
            PresetNameView()
        }.defaultSize(width: 300, height: 150)
        
        Settings {
            SettingsView()
        }
    }
}
