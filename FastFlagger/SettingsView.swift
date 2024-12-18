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
        let saveDataLocation = URL.documentsDirectory.appendingPathComponent("FlopFlagger", isDirectory: true)
        let flagsFileURL = saveDataLocation.appendingPathComponent("Flags.json")
        let activeFlagsFileURL = saveDataLocation.appendingPathComponent("ActiveFlags.json")
        
        VStack {
            Image(systemName: "person.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Created by SunnyFlops")
            
            Text("Not intended for commercial or destructive use")
            
            HStack {
                Image(systemName: "network.fill")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Button("Discord Support & Updates") {
                    @Environment(\.openURL) var openURL
                    
                    if let url = URL(string: "https://discord.com/invite/XQ3wJh3tXw") {
                        openURL(url)
                    }
                }
            }
            
            Button("Export JSON") {
                let dictionary: [String:String] = flags
                let conData = convertJSONStringToJSONData(dictionary)
                
                saveJSON(conData!)
                
            }
            
            Button("Import JSON") {
                importJSONToFlags()
            }
            
            Button("Disable App Flags") {
                activeFlags.removeAll()
            }.buttonStyle(.borderedProminent).tint(.teal)
            
            Button("Remove Client Flags") {
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: "/Applications/Roblox.app/Contents/MacOS/ClientSettings/ClientAppSettings.json") {
                    try! fileManager.removeItem(atPath: "/Applications/Roblox.app/Contents/MacOS/ClientSettings/ClientAppSettings.json")
                }
            }.buttonStyle(.borderedProminent).tint(.purple)
            
            Button("Clear App Flags") {
                flags.removeAll()
                activeFlags.removeAll()
                reloadContentViewOnly()
                
                let fileManager = FileManager.default
                
                if fileManager.fileExists(atPath: flagsFileURL.path()) {
                    try! fileManager.removeItem(at: flagsFileURL)
                }
                
                if fileManager.fileExists(atPath: activeFlagsFileURL.path()) {
                    try! fileManager.removeItem(at: activeFlagsFileURL)
                }
            }.buttonStyle(.borderedProminent).tint(.red)
            
            Spacer()
            
            Text("Client Version: \(clientVersion)")
            Text("Studio Version: \(studioVersion)")
            
        }.padding()
        
    }
}
