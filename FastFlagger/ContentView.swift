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

func saveJSON(_ jsonString: String) {
    let savePanel = NSSavePanel() // erroring, fix
    let bundleFile = Bundle.main.url(forResource: "MyCustom", withExtension: "zip")!

    savePanel.directoryURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    
    savePanel.message = "Save your FFlag JSON"
    savePanel.nameFieldStringValue = "FlopFlaggerExport.json"
    savePanel.showsHiddenFiles = false
    savePanel.showsTagField = false
    savePanel.canCreateDirectories = true
    savePanel.allowsOtherFileTypes = false
    savePanel.isExtensionHidden = true
    
    if let url = savePanel.url, savePanel.runModal().rawValue == NSApplication.ModalResponse.OK.rawValue {
        print("Now copying", bundleFile.path, "to", url.path)
        // Do the actual copy:
        do {
            try FileManager().copyItem(at: bundleFile, to: url)
        } catch {
            print(error.localizedDescription)
        }
    } else {
        print("canceled")
    }
}

func reloadContentViewAfterDelete() {
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    dismissWindow(id: "content")
    openWindow(id: "content")
}

func convertDictionaryToJSON(_ dictionary: [String: Any]) -> String? {
    guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
        print("Something is wrong while converting dictionary to JSON data.")
        return nil
    }
    guard let jsonString = String(data: jsonData, encoding: .utf8) else {
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
            activeFlags.updateValue(flags[flag] ?? "", forKey: flag)
        } else if flags[flag].customMirror.subjectType == Bool.self {
            activeFlags.updateValue(flags[flag] ?? false, forKey: flag)
        } else if flags[flag].customMirror.subjectType == Int.self {
            activeFlags.updateValue(flags[flag] ?? 0, forKey: flag)
        } else if flags[flag].customMirror.subjectType == Double.self {
            activeFlags.updateValue(flags[flag] ?? 0.0, forKey: flag)
        } else {
            activeFlags.updateValue(flags[flag] ?? "", forKey: flag)
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
                        
                        saveJSON(output!)
                        
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
                    Image(systemName: "gamecontroller.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Button("Open Client") {
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
                        
                        Button("􀈒") {
                            deleteFlag(flag)
                        }.padding().buttonStyle(.borderedProminent).tint(.red)
                        
                        Spacer()
                        
                        Button("􀆨") {
                            flagStatusControl(flag)
                        }.padding().buttonStyle(.borderedProminent).tint(.red)
                    }
                }
            }
            Spacer()
        }
    }
    func reList() {
        
    }
}

#Preview {
    ContentView()
}
