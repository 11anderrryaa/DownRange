//
//  ModelController.swift
//  DownRange
//
//  Created by Ryan Anderson on 2/24/22.
//

import Foundation

class ModelController {
    
    var gun: Gun?
    var guns: [Gun]  = []
    var profiles: [Profile] {
        guard let gun = gun else { return []}
        return gun.profiles
    }
    
    static func saveToFile(guns: [Gun]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedGuns = try? propertyListEncoder.encode(guns)
        try? encodedGuns?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Gun] {
        let propertyListDecoder = PropertyListDecoder()
        if let  retrivedGunsData = try? Data(contentsOf: archiveURL),
           let decodedGuns = try? propertyListDecoder.decode(Array <Gun>.self, from: retrivedGunsData) {
            return decodedGuns
        }
        return []
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("Gun").appendingPathExtension("plist")
}
