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
    
    init() {
        loadUserData()
    }
    
    var body: some Scene {
        WindowGroup("FlopFlagger", id: "content") {
            ContentView()
        }.defaultSize(width: 1200, height: 650)
        
        Window("Add/Edit Flags", id: "addflag") {
            AddFlagView()
        }.defaultSize(width: 450, height: 250)
        
        Window("Additional", id: "settings") {
            SettingsView()
        }.defaultSize(width: 375, height: 225)
        
        Window("Coming Soon", id: "comingsoon") {
            ComingSoonView()
        }.defaultSize(width: 150, height: 150)
        
        Window("Task Completed", id: "done") {
            CompletedView()
        }.defaultSize(width: 150, height: 150)
        
        Window("Presets", id: "presets") {
            PresetsView()
        }.defaultSize(width: 500, height: 600)
        
        WindowGroup("Preset Name", id: "presetNaming") {
            PresetNameView()
        }.defaultSize(width: 300, height: 150)
        
        Settings {
            SettingsView()
        }
    }
}
