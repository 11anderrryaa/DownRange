//
//  RangeTableViewController.swift
//  DownRange
//
//  Created by Ryan Anderson on 12/22/20.
//

import UIKit

class RangeTableViewController: UITableViewController {
    
    var gun : Gun?
    var mc = ModelController()
    var profiles: [Profile] {
        guard let gun = gun else {return []}
        //gun.profiles are the Scope Settings
        return gun.profiles
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }
    
    //MARK: - UIButton Methods
    
    @IBAction func infoButtonTapped(_ sender: Any?) {
        // If user hasn't added any gun, this message will show
        if gun?.profiles.count == 0 {
            let infoAlertController = UIAlertController(title: "Add Starting Range", message: "Zero in your scope and add that distance to scope settings", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Back", style: .cancel, handler: .none)
            infoAlertController.addAction(cancelButton)
            present(infoAlertController, animated: true, completion: nil)
        } else { // If user has guns added, this message will show
            let infoAlertController = UIAlertController(title: "Zero in your scope before you select the desired distance", message: nil, preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Back", style: .cancel, handler: .none)
            infoAlertController.addAction(cancelButton)
            present(infoAlertController, animated: true, completion: nil)
        }
    }
    
    //MARK: - Segue Methods
//
    @IBAction func unwindFromZeroDistance(_ segue: UIStoryboardSegue) {
        guard segue.source is ZeroDistanceViewController else { return }
        ModelController.saveToFile(guns: mc.guns)
        reloadTableView()
    }
    
    // MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdjustmentCell", for: indexPath) as? MilsAdustmentTableViewCell
        else { return UITableViewCell() }
        
           let sortedProfiles = profiles.sorted(by: { $0.yards < $1.yards })
           let profile = sortedProfiles[indexPath.row]
           var selectedProfile : Profile?

//        Debuggy: rows wont load with data unless a row is selected trigger this block
           if let indexPath = tableView.indexPathForSelectedRow {
               selectedProfile = sortedProfiles[indexPath.row]
               print(selectedProfile, "Debuggy")
           }
           cell.updateView(with: profile, selectedProfile: selectedProfile)
           cell.yardsButton.titleLabel?.text = "???"
           cell.yardsButton.title(for: .normal)
           return cell
       }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return profiles.count
    }
    
    //MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gun?.profiles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        ModelController.saveToFile(guns: mc.guns)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reloadTableView()
    }
    
    //MARK: - UI Update Methods
    
    func reloadTableView() {
        let indexPath = tableView.indexPathForSelectedRow
        
        tableView.reloadData()
        // If there is more than one profile added, then user can select between the different adjustments
        if profiles.count > 1 {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
}
