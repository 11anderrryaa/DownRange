//
//  GunTableViewCell.swift
//  DownRange
//
//  Created by Ryan Anderson on 12/23/20.
//

import UIKit

class GunTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gunName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Confirgure Cell Method
    
    func configure(gun: Gun){
        gunName.text = gun.name
    }
}
