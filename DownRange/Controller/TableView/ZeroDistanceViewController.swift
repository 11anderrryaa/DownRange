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
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
    }
    
    //MARK: - Methods for UIButtons
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let distance = yardsTextField.text,
              let x = upDownTextField.text,
              let y = leftRightTextField.text
        else { return }
        
        profile?.yards = Int(distance) ?? 0
        profile?.x = Double(x) ?? 0
        profile?.y = Double(y) ?? 0
    }
    
    @IBAction func infoButtonTapped(_ sender: UIBarButtonItem) {
        let infoAlertController = UIAlertController(title: K.Alert.howToTitle, message: K.Alert.howToMessage, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: K.Alert.cancel, style: .cancel, handler: .none)
        infoAlertController.addAction(cancelButton)
        present(infoAlertController, animated: true, completion: nil)
    }
    
    //MARK: - UI Update Methods
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let yardsText = yardsTextField.text ?? ""
        let upDownText = upDownTextField.text ?? ""
        saveButton.isEnabled = !yardsText.isEmpty && !upDownText.isEmpty
    }
    
    //MARK: - Segue Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard
            let yards = yardsTextField.text ,
            let x = upDownTextField.text,
            let y = leftRightTextField.text
        else { return }
        
        let profile = Profile(
            yards: Int(yards) ?? 0,
            x: Double(x) ?? 0.0,
            y: Double(y) ?? 0.0
        )
        
        let destination = segue.destination as! RangeTableViewController
        destination.gun?.profiles.append(profile)
    }
}
