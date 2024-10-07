//
//  PresetsView.swift
//  FlopFlagger
//
//  Created by SunnyFlops on 21/09/2024.
//

import SwiftUI

let presetLocation = URL.documentsDirectory.appending(path: "FlopFlagger/Presets")
let plStr = presetLocation.path()

let fileManager = FileManager.default

func openAndSelectFile(_ filename:String) {
    let files = [URL(fileURLWithPath: filename)];
    NSWorkspace.shared.activateFileViewerSelecting(files);
}

func getFiles(in url: URL) -> [URL] {
    var files: [URL] = []
    do {
        let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
        let jsonFiles = contents.filter { $0.pathExtension == "json" }
        
        for file in jsonFiles {
            files.append(file)
            if file.hasDirectoryPath {
                files += getFiles(in: file)
            }
        }
    } catch {print(error.localizedDescription)}
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
                
                Button("Preset Folder") {openAndSelectFile(plStr)}.padding()
                
                Spacer()
                
                Button("Get More Presets") {
                    @Environment(\.openURL) var openURL
                    
                    if let url = URL(string: "https://discord.com/invite/XQ3wJh3tXw") {openURL(url)}
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
                            activeFlags = try! JSONDecoder().decode([String: String].self, from: Data(contentsOf: file))
                            reloadContentViewOnly()
                            closePresets()
                        }
                    }
                }
            }.listStyle(.inset(alternatesRowBackgrounds: true))
        }
    }
}
