//
//  ProfileController.swift
//  DownRange
//
//  Created by Ryan Anderson on 2/28/22.
//

import Foundation

class ProfileController {
    
    private init() {}
    static let shared = ProfileController()
    
    var profiles: [Profile] = []
    
    func fetchProfiles(from gun: Gun?) -> [Profile] {
        return gun?.profiles ?? [Profile(yards: 0, x: 0, y: 0)]
    }
}
