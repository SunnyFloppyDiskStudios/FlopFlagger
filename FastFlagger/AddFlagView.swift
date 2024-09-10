//
//  AddFlagView.swift
//  FastFlagger
//
//  Created by SunnyFlops on 08/09/2024.
//

import SwiftUI
import Foundation
import ExtensionKit

let states = ["String", "Number", "Bool"]

var flags: [String: Any] = [
    :
]

var activeFlags: [String: Any] = [
    :
]

func addFlagToFlags(_ flag: String, _ type: String, _ val: String) {
    var trueValue: Any = val
    
    if type == "String" {
        trueValue = String(val)
    } else if type == "Number" {
        if val.firstIndex(of: ".") != nil {
            trueValue = Double(val) ?? 0.0
        } else {
            trueValue = Int(val) ?? 0
        }
        
        trueValue = Double(val) ?? 0.0
    } else if type == "Bool" {
        let lowerVal = val.lowercased()
        trueValue = Bool(lowerVal) ?? false
    }
    
    flags.updateValue(trueValue, forKey: flag)
    activeFlags.updateValue(trueValue, forKey: flag)
    print(flags)
}

func reloadContentView() {
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    dismissWindow(id: "content")
    openWindow(id: "content")
    dismissWindow(id: "addflag")
    openWindow(id: "addflag")
}

struct AddFlagView: View {
    @State var flagEntered: String = ""
    @State var valueEntered: String = ""
    @State var selection = "String"
    var body: some View {
        VStack {
            Image(systemName: "flag.badge.ellipsis.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            HStack {
                TextField(
                    "Insert Flag",
                    text: $flagEntered
                ).multilineTextAlignment(.center)
                Picker("", selection: $selection) {
                    ForEach(states, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
            }
            TextField(
                "Flag Value",
                text: $valueEntered
            ).multilineTextAlignment(.center)
            
            Button("Insert Flag") {
                addFlagToFlags(flagEntered, selection, valueEntered)
                reloadContentView()
            }
        }
    }
}

#Preview {
    AddFlagView()
}
