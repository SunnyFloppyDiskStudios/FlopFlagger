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

func saveUserData() {
    let fileManager = FileManager.default
    
    let dd = URL.documentsDirectory
    let saveDataLocation = dd.appendingPathComponent("FlopFlagger", isDirectory: true)
    
    try? fileManager.createDirectory(at: saveDataLocation, withIntermediateDirectories: false)
    
    let flagsFileURL = saveDataLocation.appendingPathComponent("Flags.json")
    let activeFlagsFileURL = saveDataLocation.appendingPathComponent("ActiveFlags.json")
    
    let flagsJSON = try! JSONEncoder().encode(flags)
    let activeFlagsJSON = try! JSONEncoder().encode(activeFlags)
    
    try? flagsJSON.write(to: flagsFileURL)
    try? activeFlagsJSON.write(to: activeFlagsFileURL)
}

func loadUserData() {
    let fileManager = FileManager.default
    let saveDataLocation = URL.documentsDirectory.appendingPathComponent("FlopFlagger", isDirectory: true)
    let flagsFileURL = saveDataLocation.appendingPathComponent("Flags.json")
    let activeFlagsFileURL = saveDataLocation.appendingPathComponent("ActiveFlags.json")
    
    if fileManager.fileExists(atPath: flagsFileURL.path()) {
        flags = try! JSONDecoder().decode([String: String].self, from: Data(contentsOf: flagsFileURL))
        print(flags)
    }
    
    if fileManager.fileExists(atPath: activeFlagsFileURL.path()) {
        activeFlags = try! JSONDecoder().decode([String: String].self, from: Data(contentsOf: activeFlagsFileURL))
    }
}
