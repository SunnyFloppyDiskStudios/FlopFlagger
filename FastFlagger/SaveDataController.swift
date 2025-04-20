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

var searchedFlags: [String: Bool] = [
    :
]

func saveUserData() {
    let fileManager = FileManager.default
    
    let dd = URL.documentsDirectory
    let saveDataLocation = dd.appendingPathComponent("FlopFlagger", isDirectory: true)
    
    try? fileManager.createDirectory(at: saveDataLocation, withIntermediateDirectories: false)
    
    let flagsFileURL = saveDataLocation.appendingPathComponent("Flags.json")
    
    let flagsJSON = try! JSONEncoder().encode(flags)
    
    try? flagsJSON.write(to: flagsFileURL)
}

func loadUserData() {
    let fileManager = FileManager.default
    let saveDataLocation = URL.documentsDirectory.appendingPathComponent("FlopFlagger", isDirectory: true)
    let flagsFileURL = saveDataLocation.appendingPathComponent("Flags.json")
    
    if fileManager.fileExists(atPath: flagsFileURL.path()) {
        flags = try! JSONDecoder().decode([String: String].self, from: Data(contentsOf: flagsFileURL))
        print(flags)
    }
}
