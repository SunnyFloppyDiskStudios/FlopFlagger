//
//  ContentView.swift
//  FastFlagger
//
//  Created by SunnyFlops on 07/09/2024.
//

import SwiftUI
import Foundation
import Combine
import ExtensionKit
import UniformTypeIdentifiers

let workspace = NSWorkspace.shared
let applications = workspace.runningApplications

func convertJSONStringToJSONData(_ jsonEncodeTo: [String:String]) -> Data? {
    do {
        let jse = JSONEncoder()
        jse.outputFormatting = .prettyPrinted
        let dataJSON = try! jse.encode(jsonEncodeTo)
        
        return dataJSON
    }
}

func createFile(_ atPath: String, _ contents: Data?, _ urlAsURL: URL, _ attributes: [FileAttributeKey : Any]? = nil) -> Bool {
    print(atPath)
    print(contents ?? "no bytes found in contents")
    print(attributes ?? "no attributes")
    print(urlAsURL)
    
    let fullURL = urlAsURL.appendingPathComponent("flopflags.json")
    print(fullURL)
    
    if FileManager().fileExists(atPath: urlAsURL.path) {
        do {
            let fileHandle = try FileHandle(forWritingTo: fullURL)
            
            fileHandle.seekToEndOfFile()
            
            do {
                try fileHandle.write(contentsOf: contents!)
            } catch {
                print(error.localizedDescription)
            }
            
        } catch {
            do {
                try contents!.write(to: fullURL)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    return true
}

func saveJSON(_ jsonData: Data) {
    let dialog = NSOpenPanel();
    
    dialog.title = "Save your FFlag";
    dialog.showsResizeIndicator = false;
    dialog.showsHiddenFiles = false;
    dialog.allowsMultipleSelection = false;
    dialog.canChooseFiles = false;
    dialog.canChooseDirectories = true;
    dialog.allowedContentTypes = [.json];
    
    
    if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
        let result = dialog.url
        
        if (result != nil) {
            let path: String = (result?.path())!
            
            let success = createFile(path, jsonData, result!)
            if success {
                @Environment(\.openWindow) var openWindow
                openWindow(id: "done") // change
            }
        }
    } else {return}
}

func applyJSON(_ jsonData: Data) {
    let fileManager = FileManager.default
    let umpobcb = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
    umpobcb[0] = true
    let isD = umpobcb
    
    if !fileManager.fileExists(atPath: "/Applications/Roblox.app/Contents/MacOS/ClientSettings/", isDirectory: isD) {
        try! fileManager.createDirectory(at: URL(fileURLWithPath: "/Applications/Roblox.app/Contents/MacOS/ClientSettings"), withIntermediateDirectories: true)
    }
    
    if !fileManager.fileExists(atPath: "/Applications/Roblox.app/Contents/MacOS/ClientSettings/ClientAppSettings.json") {
        fileManager.createFile(atPath: "/Applications/Roblox.app/Contents/MacOS/ClientSettings/ClientAppSettings.json", contents: jsonData)
    } else {
        try! fileManager.removeItem(atPath: "/Applications/Roblox.app/Contents/MacOS/ClientSettings/ClientAppSettings.json")
        fileManager.createFile(atPath: "/Applications/Roblox.app/Contents/MacOS/ClientSettings/ClientAppSettings.json", contents: jsonData)
    }
}

func reloadContentViewOnly() {
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    dismissWindow(id: "content")
    openWindow(id: "content")
}

func deleteFlags(_ flagsToDelete: Set<String>) {
    for key in flagsToDelete {
        flags.removeValue(forKey: key)
    }
    reloadContentViewOnly()
}

func getFlagValue(_ flag: String) -> Any {
    return flags[flag]! as Any
}

func getFlagValueAsString(_ flag: String) -> any StringProtocol {
    @State var flagValue: Any = flags[flag]!
    @State var returnValue = "\(flagValue)"
    
    return returnValue as any StringProtocol
}

func searchFlags(_ userInput: String) {
    searchedFlags.removeAll()
    
    for flag in flags {
        if flag.key.localizedCaseInsensitiveContains(userInput) {
            searchedFlags[flag.key] = true
        }
    }
    
    reloadContentViewOnly()
}


struct FlagItem: Identifiable {
    var id: String { flag }
    let flag: String
    let value: String
}

struct ContentView: View {
    @Environment(\.openWindow) var openWindow
    
    @State var search: String = ""
    
    @State private var selectedFlagIDs = Set<String>()
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "flag.badge.ellipsis.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Button("Insert Flag") {
                        openWindow(id: "addflag")
                    }
                }.padding()
                
                HStack {
                    Image(systemName: "internaldrive.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Button("Save") {
                        saveUserData()
                    }.buttonStyle(.borderedProminent).tint(.accentColor)
                }.padding()
                
                HStack {
                    Image("rolobox")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Button("Apply & Open Client") {
                        
                        let dictionary: [String:String] = flags
                        let conData = convertJSONStringToJSONData(dictionary)
                        
                        saveUserData()
                        
                        applyJSON(conData!)
                        
                        let robloxPlayer = NSURL(fileURLWithPath: "/Applications/Roblox.app", isDirectory: true) as URL
                        NSWorkspace.shared.open(robloxPlayer)
                    }.buttonStyle(.borderedProminent).tint(.accentColor)
                }.padding()
                
                Spacer()
                
                HStack {
                    Button("Presets") {
                        openWindow(id: "presets")
                    }
                    Image(systemName: "archivebox.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }.padding()
                
                HStack {
                    Button("Additional") {
                        openWindow(id: "settings")
                    }
                    
                    Image(systemName: "gearshape.2.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }.padding()
            }
            
            Spacer()
            
            /// **CONTENT**
            var flagItems: [FlagItem] {
                flags.keys.map { key in
                    FlagItem(flag: key, value: getFlagValueAsString(key) as? String ?? "")
                }
            }

            Table(flagItems.sorted { $0.flag < $1.flag }, selection: $selectedFlagIDs) {
                TableColumn("Flag") { item in
                    Text(item.flag)
                        .foregroundStyle(
                            searchedFlags.index(forKey: item.flag) != nil ? .yellow :
                            .primary
                        )
                }
                TableColumn("Value") { item in
                    Text(item.value)
                        .multilineTextAlignment(.center)
                }
            }
            .tableStyle(.inset)


            
            Spacer()
            
            HStack {
                Button("Delete") {
                    deleteFlags(selectedFlagIDs)
                    selectedFlagIDs.removeAll()
                }
                .buttonStyle(.borderedProminent).tint(.red)
                
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("FFlag Search")
                
                TextField(
                    "Search",
                    text: $search
                ).multilineTextAlignment(.center).onSubmit {
                    searchFlags(search)
                }.textFieldStyle(.roundedBorder)
            }.padding()
            
            
        }.onAppear() {
            Task {
                await loadContent()
            }
            loadUserData()
        }.onDisappear() {
            saveUserData()
        }
    }
}


#Preview {
    ContentView()
}
