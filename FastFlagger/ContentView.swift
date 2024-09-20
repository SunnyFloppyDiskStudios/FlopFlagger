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

func convertJSONStringToJSONData(_ jsonString: String) -> Data? {
    do {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .withoutEscapingSlashes
        
        let dataJSON = try jsonEncoder.encode(jsonString)
        
        return dataJSON
    } catch {
        print(error.localizedDescription)
        return nil
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
                openWindow(id: "done")
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

func reloadContentViewAfterDelete() {
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    dismissWindow(id: "content")
    openWindow(id: "content")
}

func convertDictionaryToJSON(_ dictionary: [String: Any]) -> String? {
    guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
        print("Something is wrong while converting dictionary to JSON data.")
        return nil
    }
    guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else {
        print("Something is wrong while converting JSON data to JSON string.")
        return nil
    }
    return jsonString
}



func deleteFlag(_ flag: String) {
    flags.removeValue(forKey: flag)
    reloadContentViewAfterDelete()
}

func flagStatusControl(_ flag: String) {
    @State var colourToggle: Bool = false
    
    if activeFlags[flag] != nil {
        activeFlags.removeValue(forKey: flag)
    } else {
        if flags[flag].customMirror.subjectType == String.self {
            activeFlags.updateValue(flags[flag] ?? "ERR_CORRUPT_VAL", forKey: flag)
        }
    }
}

func getFlagValue(_ flag: String) -> Any {
    return flags[flag]! as Any
}

func getFlagValueAsString(_ flag: String) -> any StringProtocol {
    @State var flagValue: Any = flags[flag]!
    @State var returnValue = "\(flagValue)"
    
    return returnValue as any StringProtocol
}

struct ContentView: View {
    @Environment(\.openWindow) var openWindow
    
    @State var isActiveToggleOn: Bool = false
    
    @State var search: String = ""
    
    //    func SearchInFlags() {
    //        if let flagsJ = flags as? [String: Any], let code = flags["code"] as? Int {
    //          print(code)
    //        }
    //
    //        let flagValue = flags.object(forKey: search)
    //        let flag
    //    }
    
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
                    Image(systemName: "square.and.arrow.up")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Button("Export JSON") {
                        let dictionary: [String: Any] = flags
                        let output = convertDictionaryToJSON(dictionary)
                        let conData = convertJSONStringToJSONData(output!)
                        
                        saveJSON(conData!)
                        
                    }.padding()
                }
                
                HStack {
                    Image(systemName: "square.and.arrow.down")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Button("Import JSON") {
                        openWindow(id: "comingsoon")
                    }.padding()
                }
                
                HStack {
                    Image(systemName: "internaldrive.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Button("Save") {
                        saveUserData()
                    }.padding().buttonStyle(.borderedProminent).tint(.accentColor)
                }
                
                HStack {
                    Image(systemName: "gamecontroller.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Button("Apply, & Open Client") {
                        
                        let dictionary: [String: Any] = flags
                        let output = convertDictionaryToJSON(dictionary)
                        let conData = convertJSONStringToJSONData(output!)
                        
                        saveUserData()
                        
                        applyJSON(conData!)
                        
                        let robloxPlayer = NSURL(fileURLWithPath: "/Applications/Roblox.app", isDirectory: true) as URL
                        NSWorkspace.shared.open(robloxPlayer)
                    }.padding().buttonStyle(.borderedProminent).tint(.accentColor)
                }
                
                Spacer()
                
                HStack {
                    Button("Presets") {
                        openWindow(id: "comingsoon")
                    }
                    Image(systemName: "archivebox.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }.padding()
                
                HStack {
                    Button("Settings") {
                        openWindow(id: "settings")
                    }
                    
                    Image(systemName: "gearshape.2.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }.padding()
            }
            
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("FFlag Search")
                }
                
                TextField(
                    "COMING SOON!",
                    text: $search
                ).multilineTextAlignment(.center).onSubmit {
                    openWindow(id: "comingsoon")
                }
            }
            
            Divider()
            Spacer()
            
            /// **TITLES**
            
            HStack {
                VStack {
                    Image(systemName: "flag.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Flags")
                }.padding()
                
                Spacer()
                
                VStack {
                    Image(systemName: "number")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Value")
                }.padding()
                

                
                Spacer()
                
                VStack {
                    Image(systemName: "trash.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Delete")
                }.padding()
                
                Spacer()
                
                VStack {
                    Image(systemName: "hand.raised.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Active")
                }.padding()
            }
            
            /// **CONTENT**
            VStack {
                ForEach(Array(flags.keys), id: \.self) { flag in
                    HStack {
                        Text(flag).padding()
                        
                        Spacer()
                        
                        Text(getFlagValueAsString(flag)).padding() // Flag Value
                        
                        Spacer()
                        
                        Button("􀆨") {
                            flagStatusControl(flag)
                        }.padding().buttonStyle(.borderedProminent).tint(.blue)
                        
                        Spacer()
                        
                        Button("􀈒") {
                            deleteFlag(flag)
                        }.padding().buttonStyle(.borderedProminent).tint(.red)
                        
                    }
                }
            }
            Spacer()
        }.onAppear() {
            loadContent()
            loadUserData()
        }
    }
}

#Preview {
    ContentView()
}
