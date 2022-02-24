//
//  RangeTableViewController.swift
//  DownRange
//
//  Created by Ryan Anderson on 12/22/20.
//

import UIKit

class RangeTableViewController: UITableViewController {
    
    var gun : Gun?
    var guns : [Gun] = []
    var profiles : [Profile] {
        guard let gun = gun else {return []}
        //gun.profiles are the Scope Settings
        return gun.profiles
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - UIButton Methods
    
    @IBAction func infoButtonTapped(_ sender: Any?) {
        if gun?.profiles.count == 0 {
            let infoAlertController = UIAlertController(title: "Add Starting Range", message: "Zero in your scope and add that distance to scope settings", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Back", style: .cancel, handler: .none)
            infoAlertController.addAction(cancelButton)
            present(infoAlertController, animated: true, completion: nil)
        } else {
            let infoAlertController = UIAlertController(title: "Zero in your scope before you select the desired distance", message: nil, preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Back", style: .cancel, handler: .none)
            infoAlertController.addAction(cancelButton)
            present(infoAlertController, animated: true, completion: nil)
        }
    }
    
    //MARK: - Segue Methods
    
    @IBAction func unwindFromZeroDistance(_ segue: UIStoryboardSegue) {
        guard segue.source is ZeroDistanceViewController else { return }
        Gun.saveToFile(guns: guns)
        reloadTableView()
    }
    
    // MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "AdjustmentCell", for: indexPath) as! MilsAdustmentTableViewCell
           let sortedProfiles = profiles.sorted(by: { $0.yards < $1.yards })
           let profile = sortedProfiles[indexPath.row]
           var selectedProfile : Profile?
           
           if let indexPath = tableView.indexPathForSelectedRow {
               selectedProfile = sortedProfiles[indexPath.row]
           }
           cell.updateView(with: profile, selectedProfile: selectedProfile)
           cell.yardsButton.titleLabel?.text = "???"
           cell.yardsButton.title(for: .normal)
           return cell
       }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return profiles.count
        } else {
            return 1
        }
    }
    
    //MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gun?.profiles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        Gun.saveToFile(guns: guns)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reloadTableView()
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let gun = gun else {return}
        let movedRange = gun.profiles.remove(at: sourceIndexPath.row)
        gun.profiles.insert(movedRange, at: destinationIndexPath.row)
        Gun.saveToFile(guns: guns)
        reloadTableView()
    }
    
    //MARK: - UI Update Methods
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }
    
    func reloadTableView() {
        let indexPath = tableView.indexPathForSelectedRow
        
        tableView.reloadData()
        if profiles.count > 1 {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
}
