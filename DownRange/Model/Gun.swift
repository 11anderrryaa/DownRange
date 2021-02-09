//
//  Gun.swift
//  DownRange
//
//  Created by Ryan Anderson on 1/20/21.
//

import Foundation

class Gun : Codable {
    
    var name : String
    var profiles : [Profile] = []
//    var velocity : Double
//    var energy : Double
//    var time : Double
    
    init (name: String/*, velocity: Double, energy: Double, time: Double*/) {
        self.name = name
//        self.velocity = velocity
//        self.energy = energy
//        self.time = time
        
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
