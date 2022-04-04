//
//  GunCollectionViewCell.swift
//  DownRange
//
//  Created by Ryan Anderson on 4/4/22.
//

import UIKit

class GunCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var gunImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image: UIImage) {
        gunImage.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "GunCollectionViewCell", bundle: nil)
    }

}
