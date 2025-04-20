//
//  PreLoad.swift
//  FlopFlagger
//
//  Created by SunnyFlops on 19/09/2024.
//
// Mac Client - https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer ; Mac..Player
// Mac Studio - https://clientsettingscdn.roblox.com/v2/client-version/MacStudio ; Mac..Studio
//

import Foundation

var clientProcessed = [String:String]()
var studioProcessed = [String:String]()

func loadContent() async {
    async let clientResult = fetchVersion(from: "https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer")
    async let studioResult = fetchVersion(from: "https://clientsettingscdn.roblox.com/v2/client-version/MacStudio")
    
    do {
        clientProcessed = try await clientResult
        studioProcessed = try await studioResult
    } catch {
        print("Error fetching versions: \(error.localizedDescription)")
    }
    
    let clientCVU = clientProcessed["clientVersionUpload"] ?? "ERR_NO_INTERNET"
    let studioCVU = studioProcessed["clientVersionUpload"] ?? "RESTART_APP"
    
    writeVersions(clientCVU, studioCVU)
}

private func fetchVersion(from urlString: String) async throws -> [String:String] {
    guard let url = URL(string: urlString) else {
        print("Invalid URL: \(urlString)")
        return [:]
    }

    let (data, _) = try await URLSession.shared.data(from: url)
    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:String]
    return json ?? [:]
}
