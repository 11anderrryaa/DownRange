//
//  Clicks.swift
//  DownRange
//
//  Created by Ryan Anderson on 12/22/20.
//

import Foundation


struct Profile : Codable {
    
    var yards: Int
    
    var x: Double
    
    var y: Double
    
    
    
    init(yards: Int, x: Double, y: Double) {
       
        self.yards = yards
        self.x = x
        self.y = y
    }
    
    static func saveToFile(profiles: [Profile]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedProfiles = try? propertyListEncoder.encode(profiles)
        try? encodedProfiles?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Profile] {
        let propertyListDecoder = PropertyListDecoder()
        if let  retrivedProfilesData = try? Data(contentsOf: archiveURL),
           let decodedProfiles = try? propertyListDecoder.decode(Array <Profile>.self, from: retrivedProfilesData) {
            return decodedProfiles
        }
        return []
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("DownRange.Profile").appendingPathExtension("plist")
}




