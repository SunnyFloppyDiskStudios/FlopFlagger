//
//  ImportController.swift
//  FlopFlagger
//
//  Created by Arav Prasad on 23/09/2024.
//

import Foundation
import ExtensionKit


func importJSONToFlags() {
    let dialog = NSOpenPanel();
    
    dialog.title = "Import Flags";
    dialog.showsResizeIndicator = false;
    dialog.showsHiddenFiles = false;
    dialog.allowsMultipleSelection = false;
    dialog.canChooseFiles = true;
    dialog.canChooseDirectories = false;
    dialog.allowedContentTypes = [.json];
    
    if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
        let result = dialog.url
        
        if (result != nil) {
            flags = try! JSONDecoder().decode([String: String].self, from: Data(contentsOf: result!))
            activeFlags = try! JSONDecoder().decode([String: String].self, from: Data(contentsOf: result!))
            reloadContentViewAfterDelete()
        }
    } else {return}
}
