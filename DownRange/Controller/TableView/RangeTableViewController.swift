//
//  RangeTableViewController.swift
//  DownRange
//
//  Created by Ryan Anderson on 12/22/20.
//

import UIKit

class RangeTableViewController: UITableViewController {
    
    var gun : Gun?
    var gunController = GunController.shared
    var profileController = ProfileController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadTableView()
    }
    
    //MARK: - UIButton Methods
    
    @IBAction func infoButtonTapped(_ sender: Any?) {
        // If user hasn't added any gun, this message will show
        if gun?.profiles.count == 0 {
            showAlert(title: K.Alert.addDataTitle, message: K.Alert.addDatamessage, textField: false)
        } else { // If user has guns added, this message will show
            showAlert(title: K.Alert.useDataTitle, message: "", textField: false)
        }
    }
    
    //MARK: - Segue Methods
    
    @IBAction func unwindFromZeroDistance(_ segue: UIStoryboardSegue) {
        guard segue.source is ZeroDistanceViewController else { return }
        GunController.saveToFile(guns: gunController.guns)
        reloadTableView()
    }
    
    // MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as? MilsAdustmentTableViewCell
        else { return UITableViewCell() }
        
        
        let sortedProfiles = profileController.profiles.sorted(by: { $0.yards < $1.yards })
        let profile = sortedProfiles[indexPath.row]
        var selectedProfile : Profile?
        
        if let indexPath = tableView.indexPathForSelectedRow {
            selectedProfile = sortedProfiles[indexPath.row]
        } else {
            selectedProfile = Profile(yards: 0, x: 0, y: 0)
        }
        cell.updateView(with: profile, selectedProfile: selectedProfile)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileController.profiles.count
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gun?.profiles.remove(at: indexPath.row)
            updateData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        GunController.saveToFile(guns: gunController.guns)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reloadTableView()
    }
    
    //MARK: - UI Update Methods
    
    func reloadTableView() {
        let indexPath = tableView.indexPathForSelectedRow
        updateData()
        tableView.reloadData()
        // If there is more than one profile added, then user can select between the different adjustments
        if profileController.profiles.count == 0 {
            showAlert(title: K.Alert.firstTimeTitle, message: K.Alert.firstTimeMessage, textField: true)
        } else if profileController.profiles.count > 1 {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
    //MARK: - Update Data Methods
    
    func updateData() {
        profileController.profiles = profileController.fetchProfiles(from: gun)
    }
    
    //MARK: - AlertController Methods
    
    
    fileprivate func showAlert(title: String, message: String, textField: Bool) {
        
        let infoController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: K.Alert.cancel, style: .cancel, handler: .none)
        
        if textField == true {
            infoController.addTextField { (textField) in
                textField.placeholder = K.Alert.firstTimePlaceholder
                textField.textAlignment = .center
                textField.keyboardType = .numberPad
            }
            let saveButton = UIAlertAction(title: K.Alert.save, style: .default) { (alert) in
    
                guard
                    let textfieldArray = infoController.textFields,
                    let yardText = Int(textfieldArray[0].text ?? "0")
                else { return }
                
                let profile = Profile(yards: yardText, x: 0, y: 0)
                self.gun?.profiles.append(profile)
                
                DispatchQueue.main.async {
                    self.updateData()
                    self.tableView.reloadData()
                }
            }
            infoController.addAction(saveButton)
        }
        infoController.addAction(cancelButton)
        
        present(infoController, animated: true, completion: nil)
    }
}
