//
//  AddFlagView.swift
//  FastFlagger
//
//  Created by SunnyFlops on 08/09/2024.
//
//  UI for adding flags to the user's flags

import SwiftUI
import Combine
import Foundation
import ExtensionKit

// MARK: - FUNCTIONS
func addFlagToFlags(_ flag: String, _ type: String, _ val: String) {
    // self explanatory
    
    let trueValue: String = String(val)
    
    flags.updateValue(trueValue, forKey: flag)
    print(flags)
}

func reloadContentView() {
    // similar function exists in the ContentView
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    dismissWindow(id: "content")
    openWindow(id: "content")
    dismissWindow(id: "addflag")
    openWindow(id: "addflag")
}

// MARK: - UI
struct AddFlagView: View {
    @State var flagEntered: String = ""
    @State var valueEntered: String = ""
    @State var selection = "String"
    
    @State var isOn: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "flag.badge.ellipsis.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .padding()
            
            TextField(
                "FastFlag",
                text: $flagEntered
            ).multilineTextAlignment(.center)
            
            VStack {
                if flagEntered.contains("Flag") { // bool
                    Toggle(isOn: $isOn) {
                        Text("Flag Value")
                    }
                    
                } else if flagEntered.contains("Int") {
                    TextField("Flag Value", text: $valueEntered)
                        .onReceive(Just(valueEntered)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.valueEntered = filtered
                            }
                        }
                } else if flagEntered.contains("String") {
                    TextField("Flag Value", text: $valueEntered)
                } else {
                    Text("Invalid Flag Component")
                }
                
                // fastflags have different types which can be easily identified. this prevents improper values (however nothing bad would happen anyway)
                // is this efficient? probably not. are there edge cases? maybe.
                if flagEntered.contains("String") || flagEntered.contains("Flag") || flagEntered.contains("Int") {
                    Button("OK") {
                        if valueEntered.isEmpty {
                            if flagEntered.contains("Flag") { // bool
                                if isOn {
                                    valueEntered = "true"
                                } else {
                                    valueEntered = "false"
                                }
                            } else if flagEntered.contains("String") {
                                valueEntered = " "
                            } else if flagEntered.contains("Int") {
                                valueEntered = "0"
                            }
                        }
                        
                        addFlagToFlags(flagEntered, selection, valueEntered)
                        reloadContentView()
                    }
                }
            }.frame(height: 50)
        }
    }
}
