//
//  ZeroDistanceViewController.swift
//  DownRange
//
//  Created by Ryan Anderson on 1/4/21.
//

import UIKit

class ZeroDistanceViewController: UIViewController {

    
    var profile: Profile?
    
    @IBOutlet weak var yardsTextField: UITextField!
    
    @IBOutlet weak var upDownTextField: UITextField!
    
    @IBOutlet weak var leftRightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let distance = yardsTextField.text, let x = upDownTextField.text, let y = leftRightTextField.text else { return }
        
        profile?.yards = Int(distance)!
        profile?.x = Double(x)!
        profile?.y = Double(y)!
        
    }
    
    
    @IBAction func infoButtonTapped(_ sender: UIBarButtonItem) {
        let infoAlertController = UIAlertController(title: "Enter in the new distance in yards.", message: "Based off the shortest distance you zero'd in at, enter in the different below. (Down/Up) = (-/+)  (Left/Right) = (-/+)", preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "Back", style: .cancel, handler: .none)
        
        infoAlertController.addAction(cancelButton)
        present(infoAlertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let yards = Int(yardsTextField.text!) ?? 0
        
        let x = Double(upDownTextField.text!) ?? 0.0
        
        let y = Double(leftRightTextField.text!) ?? 0.0
        
        let profile = Profile(yards: yards, x: x, y: y)
        
        let destination = segue.destination as! RangeTableViewController
        
        destination.gun?.profiles.append(profile)
    
        
    }
}
