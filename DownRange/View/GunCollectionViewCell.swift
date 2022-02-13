//
//  GunCollectionViewCell.swift
//  DownRange
//
//  Created by Ryan Anderson on 11/16/21.
//

import UIKit

class GunCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gunName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        gunName.text = "Gun Name"
    }
    
    func configure(gun: Gun) {
            gunName.text = gun.name
        }
    }
