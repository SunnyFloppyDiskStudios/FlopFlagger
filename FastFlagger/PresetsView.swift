//
//  PresetsView.swift
//  FlopFlagger
//
//  Created by Arav Prasad on 21/09/2024.
//

import SwiftUI

let presetLocation = URL.documentsDirectory.appending(path: "FlopFlagger/Presets")
let plStr = presetLocation.path()

let fileManager = FileManager.default

func getFiles(in url: URL) -> [URL] {
    var files: [URL] = []
    do {
        let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
        let jsonFiles = contents.filter { $0.pathExtension == "json" }
        
        for file in jsonFiles {
            files.append(file)
            // Call the function recursively if the file is a directory
            if file.hasDirectoryPath {
                files += getFiles(in: file)
            }
        }
    } catch {
        print("Error while enumerating files: \(error.localizedDescription)")
    }
    return files
}

func reloadPresets() {
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    dismissWindow(id: "presetNaming")
    dismissWindow(id: "presets")
    openWindow(id: "presets")
}

func closePresets() {
    @Environment(\.dismissWindow) var dismissWindow
    dismissWindow(id: "presets")
    dismissWindow(id: "presetNaming")
}

struct PresetsView: View {
    var body: some View {
        VStack {
            HStack {
                Button("Create Preset") {
                    try? FileManager.default.createDirectory(at: presetLocation, withIntermediateDirectories: false)
                    
                    @Environment(\.openWindow) var openWindow
                    
                    openWindow(id: "presetNaming")
                }.padding()
                
                Spacer()
                
                Button("Get More Presets") {
                    @Environment(\.openURL) var openURL
                    
                    if let url = URL(string: "https://discord.com/invite/XQ3wJh3tXw") {
                        openURL(url)
                    }
                }.padding()
            }
            
            List {
                ForEach(getFiles(in: presetLocation), id: \.self) { file in
                    HStack {
                        Text(file.lastPathComponent)
                        Spacer()
                        Button("Use") {
                            print(file.lastPathComponent)
                            
                            flags = try! JSONDecoder().decode([String: String].self, from: Data(contentsOf: file))
                            reloadContentViewAfterDelete()
                            
                            closePresets()
                        }
                    }
                }
            }.alternatingRowBackgrounds()
        }
    }
}
