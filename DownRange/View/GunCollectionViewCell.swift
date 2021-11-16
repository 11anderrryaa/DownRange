//
//  GunCollectionViewCell.swift
//  DownRange
//
//  Created by Ryan Anderson on 11/16/21.
//

import UIKit

class GunCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var gunName: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    

    
    func configure(gun: Gun){
        gunName.text = gun.name
    }
    
}
}
