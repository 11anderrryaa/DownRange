//
//  MilsAdustmentTableViewCell.swift
//  DownRange
//
//  Created by Ryan Anderson on 1/5/21.
//

import UIKit

protocol YardChanged {
    func yardTapped(profile: Profile)
}

class MilsAdustmentTableViewCell: UITableViewCell {
    var profile : Profile?
    var delegate : YardChanged?
    @IBOutlet weak var yardsButton: UIButton!
    @IBOutlet weak var upDownLabel: UILabel!
    @IBOutlet weak var leftRightLabel: UILabel!
    
    func updateView(with profile: Profile?, selectedProfile: Profile?) {
        guard let yards = profile?.yards, let profileX = profile?.x, let profileY = profile?.y else {return}
        self.profile = profile
        yardsButton.setTitle(String(yards), for: .normal)
        upDownLabel.text = String(profileX - (selectedProfile?.x ?? 0))
        leftRightLabel.text = String(profileY - (selectedProfile?.y ?? 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
