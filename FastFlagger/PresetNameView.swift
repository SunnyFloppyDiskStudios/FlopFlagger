//
//  PresetNameView.swift
//  FlopFlagger
//
//  Created by Arav Prasad on 23/09/2024.
//

import SwiftUI

struct PresetNameView: View {
    @State var presetName = ""
    
    var body: some View {
        Image(systemName: "arrow.down.document")
            .imageScale(.large)
            .foregroundStyle(.tint)
        Text("Preset Name")
        TextField(
            "FastFlag Preset Name",
            text: $presetName
        ).multilineTextAlignment(.center).onSubmit {
            let fileManager = FileManager.default
            
            let presetData = try! JSONEncoder().encode(flags)
            
            let path = "\(presetLocation.appendingPathComponent(presetName))"
            
            fileManager.createFile(atPath: path, contents: presetData)
            
            do {
                let fileHandle = try FileHandle(forWritingTo: presetLocation.appendingPathComponent("\(presetName).json"))
                fileHandle.seekToEndOfFile()
                do {
                    try fileHandle.write(contentsOf: presetData)
                } catch {
                    print(error.localizedDescription)
                }
                
            } catch {
                do {
                    try presetData.write(to: presetLocation.appendingPathComponent("\(presetName).json"))
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            reloadPresets()
        }
    }
}

#Preview {
    PresetNameView()
}
