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
    
    //MARK: - Confirgure Cell Methods
    
    func configure(gun: Gun){
        gunName.text = gun.name
    }
    
}
