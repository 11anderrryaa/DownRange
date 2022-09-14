//
//  Profile.swift
//  DownRange
//
//  Created by Ryan Anderson on 12/22/20.
//

import Foundation

class Profile: Codable {
    
    var yards: Int
    var x: Double
    var y: Double
    
    init(yards: Int, x: Double, y: Double) {
        self.yards = yards
        self.x = x
        self.y = y
    }
}
