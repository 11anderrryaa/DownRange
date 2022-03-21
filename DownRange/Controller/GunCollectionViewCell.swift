//
//  GunCollectionViewCell.swift
//  DownRange
//
//  Created by Ryan Anderson on 3/19/22.
//

import UIKit
import expanding_collection

class GunCollectionViewCell: BasePageCollectionCell {

    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellImage.image = UIImage(named: "RiflePicture")
    }

}
