//
//  DropChartTableViewCell.swift
//  DownRange
//
//  Created by Ryan Anderson on 2/9/21.
//

import UIKit

class DropChartTableViewCell: UITableViewCell {
    
    var dropchart : DropChart?
    
    @IBOutlet weak var yardsLabel: UILabel!
    @IBOutlet weak var dropLabel: UILabel!
    @IBOutlet weak var velocityLebel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var timeOfFlightLabel: UILabel!
    
    func updateChart(with dropchart: DropChart?) {
        guard let range = dropchart?.range, let drop = dropchart?.drop, let velocity = dropchart?.velocity, let energy =  dropchart?.energy, let tof = dropchart?.timeOfFlight else {return}
        self.dropchart = dropchart
        yardsLabel.text = String(range)
        dropLabel.text =  String(drop)
        velocityLebel.text = String(velocity)
        energyLabel.text =  String(energy)
        timeOfFlightLabel.text = String(tof
        )}
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
