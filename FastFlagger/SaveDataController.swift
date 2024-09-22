//
//  SaveData.swift
//  FlopFlagger
//
//  Created by SunnyFlops on 16/09/2024.
//

import SwiftUI
import Foundation

var flags: [String: String] = [
    :
]

var activeFlags: [String: String] = [
    :
]

let saveDataLocation = URL.documentsDirectory
let flagsFileURL = saveDataLocation.appendingPathComponent("Flags.json")
let activeFlagsFileURL = saveDataLocation.appendingPathComponent("ActiveFlags.json")

func saveUserData() {
    let flagsJSON = try! JSONEncoder().encode(flags)
    let activeFlagsJSON = try! JSONEncoder().encode(activeFlags)
    
    try? flagsJSON.write(to: flagsFileURL)
    try? activeFlagsJSON.write(to: activeFlagsFileURL)
}

func loadUserData() {
    let fileManager = FileManager.default
    
    if fileManager.fileExists(atPath: flagsFileURL.path()) {
        flags = try! JSONDecoder().decode([String: String].self, from: Data(contentsOf: flagsFileURL))
        print(flags)
    }
    
    if fileManager.fileExists(atPath: activeFlagsFileURL.path()) {
        activeFlags = try! JSONDecoder().decode([String: String].self, from: Data(contentsOf: activeFlagsFileURL))
    }
}
