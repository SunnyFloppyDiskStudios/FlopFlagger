//
//  PreLoad.swift
//  FlopFlagger
//
//  Created by SunnyFlops on 19/09/2024.
//
// Mac Roblox Client - https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer ; Mac..Player
// Mac Roblox Studio - https://clientsettingscdn.roblox.com/v2/client-version/MacStudio ; Mac..Studio
//

import Foundation

var clientProcessed = [String:String]()
var studioProcessed = [String:String]()

func loadContent() {
    do {
        if let clientFile = URL(string: "https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer") {
            let clientData = try Data(contentsOf: clientFile)
            let clientJSON = try JSONSerialization.jsonObject(with: clientData, options: []) as! [String:String]
            clientProcessed = clientJSON
        } else {
           print("no file")
        }
    } catch {
        print(error.localizedDescription)
    }
    
    do {
        if let studioFile = URL(string: "https://clientsettingscdn.roblox.com/v2/client-version/MacStudio") {
            let studioData = try Data(contentsOf: studioFile)
            let studioJSON = try JSONSerialization.jsonObject(with: studioData, options: []) as! [String:String]
            studioProcessed = studioJSON
        } else {
           print("no file")
        }
    } catch {
        print(error.localizedDescription)
    }
    
    let clientCVU = clientProcessed["clientVersionUpload"]!
    let studioCVU = studioProcessed["clientVersionUpload"]!
    
    print(clientCVU)
    print(studioCVU)
}




