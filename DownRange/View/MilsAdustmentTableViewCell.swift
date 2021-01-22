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
        
        // Initialization code
    }
    
    @IBAction func yardsButtonTapped(_ sender: Any) {
        if let profile = profile {
            delegate?.yardTapped(profile: profile)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    static func loadSampleProfile() -> [Profile] {
//        return [Profile(name: "Gun", yards: 100, x: 0, y: 0),
//        Profile(name: "My Gun", yards: 200, x: 1, y: 1)]
//    }
}

