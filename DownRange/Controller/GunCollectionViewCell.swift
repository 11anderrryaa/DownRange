//
//  GunCollectionViewCell.swift
//  DownRange
//
//  Created by Ryan Anderson on 4/4/22.
//

import UIKit

class GunCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var gunImage: UIImageView!
    @IBOutlet weak var gunLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image: UIImage, label: String) {
        gunImage.image = image
        gunLabel.text = label
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "GunCollectionViewCell", bundle: nil)
    }

}
