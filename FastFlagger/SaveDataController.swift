//
//  SaveData.swift
//  FlopFlagger
//
//  Created by SunnyFlops on 16/09/2024.
//

import SwiftUI
import Foundation
import CoreData

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
