//
//  SaveData.swift
//  FlopFlagger
//
//  Created by SunnyFlops on 16/09/2024.
//

import SwiftUI
import Foundation
import SwiftData

struct DataController {
    @Environment(\.modelContext) static var modelContext
}


@Model class configSettingsSave {
    var configJSON: Data
    var flagsJSON: Data
    var activeFlagsJSON: Data
    
    init(configJSON: Data, flagsJSON: Data, activeFlagsJSON: Data) {
        self.configJSON = configJSON
        self.flagsJSON = flagsJSON
        self.activeFlagsJSON = activeFlagsJSON
    }
}

var UserConfig: [String:String] = [
    "PresetLocation" : "~/Desktop/Flags/",
    
]

var flags: [String: String] = [
    :
]

var activeFlags: [String: String] = [
    :
]

func saveUserData() {
    let configJSON: Data = try! JSONEncoder().encode(UserConfig)
    let flagsJSON: Data = try! JSONEncoder().encode(flags)
    let activeFlagsJSON: Data = try! JSONEncoder().encode(activeFlags)
    
    
}
