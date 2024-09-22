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

func addFlagToFlags(_ flag: String, _ type: String, _ val: String) {
    let trueValue: String = String(val)
    
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
            }
            TextField(
                "Flag Value",
                text: $valueEntered
            ).multilineTextAlignment(.center)
            
            Button("Insert Flag") {
                if valueEntered.lowercased().contains("true") {
                    valueEntered = "true"
                } else if valueEntered.lowercased().contains("false") {
                    valueEntered = "false"
                } else {
                    valueEntered = valueEntered
                }
                
                
                addFlagToFlags(flagEntered, selection, valueEntered)
                reloadContentView()
            }
        }
    }
}
