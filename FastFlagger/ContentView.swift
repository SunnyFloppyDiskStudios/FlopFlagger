//
//  ContentView.swift
//  FastFlagger
//
//  Created by SunnyFlops on 07/09/2024.
//

import SwiftUI
import Foundation

let workspace = NSWorkspace.shared
let applications = workspace.runningApplications

func reloadContentViewAfterDelete() {
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    dismissWindow(id: "content")
    openWindow(id: "content")
}

func deleteFlag(_ flag: String) {
    flags.removeValue(forKey: flag)
    print(flags)
    reloadContentViewAfterDelete()
}

func flagStatusControl(_ flag: String) {
    @State var colourToggle: Bool = false
    
    if activeFlags[flag] != nil {
        activeFlags.removeValue(forKey: flag)
        print(activeFlags)
    } else {
        print(activeFlags)
        
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
        print(activeFlags)
    }
    print("toggle \(flag)")
}

func getFlagValue(_ flag: String) -> Any {
    @State var flagValue: Any
    print(flags[flag]!)
    return flags[flag]! as Any //
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
                    "",
                    text: $search
                ).multilineTextAlignment(.center)
            }
            
            Divider()
            Spacer()
            
            HStack {
                VStack {
                    Image(systemName: "trash.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Delete")
                }.padding()
                VStack {
                    Image(systemName: "hand.raised.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Active")
                }.padding()
                
                Spacer()
                
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
                
            }
            
            /// **CONTENT**
            VStack {
                ForEach(Array(flags.keys), id: \.self) { flag in
                    HStack {
                        Button("􀈒") {
                            deleteFlag(flag)
                        }.padding().buttonStyle(.borderedProminent).tint(.red)
                        
                        Button("􀆨") {
                            flagStatusControl(flag)
                        }.padding().buttonStyle(.borderedProminent).tint(.red)
                        
                        Spacer()
                        Text(flag).padding()
                        Spacer()
                        
                        Text("flags[flag]!").padding() // Flag Value
                        Spacer()
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
