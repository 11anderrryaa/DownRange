//
//  MilsAdustmentTableViewCell.swift
//  DownRange
//
//  Created by Ryan Anderson on 1/5/21.
//

import UIKit

class MilsAdustmentTableViewCell: UITableViewCell {
    
    var profile: Profile?
    
    @IBOutlet weak var yardsButton: UIButton!
    @IBOutlet weak var upDownLabel: UILabel!
    @IBOutlet weak var leftRightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //MARK: - UI Update Methods
    
    func updateView(with profile: Profile?, selectedProfile: Profile?) {
        
        guard
            let profile = profile,
            let selectedProfile = selectedProfile
        else { return }
        
        yardsButton.setTitle("\(profile.yards)", for: .normal)
        upDownLabel.text = String(profile.x - selectedProfile.x)
        leftRightLabel.text = String(profile.y - selectedProfile.y)
    }
}
