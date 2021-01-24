//
//  Gun.swift
//  DownRange
//
//  Created by Ryan Anderson on 1/20/21.
//

import Foundation

class Gun : Codable {
    
    var name : String
    var profiles : [Profile] = [
//        Profile(yards: 100, x: 0, y: 0),
//        Profile(yards: 200, x: 1, y: 0),
//        Profile(yards: 300, x: 2, y: -0.5)
    ]
    
    init (name: String) {
        self.name = name
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
    
    static func loadExample() -> [Gun] {
        let exampleGun = Gun(name: "Enter Gun Name")
        return [exampleGun]
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("Gun").appendingPathExtension("plist")
}
