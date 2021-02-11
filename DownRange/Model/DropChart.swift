//
//  DropChart.swift
//  DownRange
//
//  Created by Ryan Anderson on 2/9/21.
//

import Foundation

class DropChart : Codable {
    
    var caliber : Double
    var weight : Double
    var muzzleVelocity : Double
    var ballisticsCoeffcient : Double
//    var zeroRange : Double
//    var scopeHeight : Double
    var range : Double
    var drop : Double
    var velocity : Double
    var energy : Double
    var timeOfFlight : Double
    
    init(caliber: Double, weight: Double, muzzleVelocity: Double,ballisticsCoeffcient: Double, range: Double, drop: Double, velocity: Double, energy: Double, timeOfFlight: Double) {
        self.caliber = caliber
        self.weight = weight
        self.muzzleVelocity = muzzleVelocity
        self.ballisticsCoeffcient = ballisticsCoeffcient
        self.range = range
        self.drop = drop
        self.velocity = velocity
        self.energy = energy
        self.timeOfFlight = timeOfFlight
    }
}
