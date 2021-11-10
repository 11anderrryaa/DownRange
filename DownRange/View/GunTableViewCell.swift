//
//  GunTableViewCell.swift
//  DownRange
//
//  Created by Ryan Anderson on 12/23/20.
//

import UIKit

class GunTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var gunName: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(gun: Gun){
        gunName.text = gun.name
    }
}
