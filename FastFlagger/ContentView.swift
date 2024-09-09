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

struct ContentView: View {
    @Environment(\.openWindow) var openWindow
    
    @State var search: String = ""
    
    @State var isActiveToggleOn: Bool = false
    
    //    func SearchInFlags() {
    //        if let flagsJ = flags as? [String: Any], let code = flags["code"] as? Int {
    //          print(code)
    //        }
    //
    //        let flagValue = flags.object(forKey: search)
    //        let flag
    //    }
    //
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
                    }.padding()
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
                
                Spacer()
                
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
            
            // CONTENT
            VStack {
                ForEach(Array(flags.keys), id: \.self) { flag in
                    HStack {
                        Spacer()
                        Button("Delete") {
                            print("delete \(flag)")
                        }.padding()
                        Toggle(isOn: $isActiveToggleOn) {}.padding().onChange(of: isActiveToggleOn) {
                            if isActiveToggleOn {
                                print("activate \(flag)")
                            } else {
                                print("deactivate \(flag)")
                            }
                        }
                        Spacer()
                        Text(flag).padding()
                        Spacer()
                        Text(flag).padding()
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
