//
//  K.swift
//  DownRange
//
//  Created by Ryan Anderson on 3/1/22.
//

import Foundation

struct K {
    
    static let cellIdentifier = "ReusableCell"
    static let addSegue = "AddGun"
    static let profileSegue = "ToProfiles"
    static let adjustmentSegue = "AddZeroDistance"
    
    struct Alert {
        
        static let newTitle = "Add Rifle Name By Pushing the + Button"
        static let addGunTitle = "Enter Rifle"
        static let placeholder = "Rifle Name💥🔫"
        static let addDataTitle = "Add Starting Range"
        static let addDatamessage = " Zero in you scope and add that to scope setting"
        static let useDataTitle = " Zero in you scope before you select the desired distance"
        static let howToTitle = "Enter in the new distance in yards."
        static let howToMessage = "Based off the shortest distance you zero'd in at, enter in the different below. (Down/Up) = (-/+)  (Left/Right) = (-/+)"
        static let firstTimeTitle = "Add Yards"
        static let firstTimeMessage = "Add where you are zero'd in at"
        static let firstTimePlaceholder = "Distance in Yards"
        static let cancel = "Cancel"
        static let save = "Save"
    }
}
