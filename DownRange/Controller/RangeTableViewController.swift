//
//  RangeTableViewController.swift
//  DownRange
//
//  Created by Ryan Anderson on 12/22/20.
//

import UIKit

class RangeTableViewController: UITableViewController, YardChanged {
    
    func yardTapped(profile: Profile) {
        
    }
    var gun : Gun? 
    var guns : [Gun] = []
    var profiles : [Profile] {
        guard let gun = gun else {return []}
        return gun.profiles //gun.profiles are the Scope Settings
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //       profiles = Profile.loadFromFile()
    }
    @IBAction func segmentControl(_ sender: Any) {
        
    }
    
    // MARK: - Table view data source
    
    @IBAction func addYards(_ sender: UIBarButtonItem) {
    }
    
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return profiles.count
        } else {
            return 0
        }
    }
    // displaying the adjustments
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdjustmentCell", for: indexPath) as! MilsAdustmentTableViewCell
        
        cell.delegate = self
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
//    // configuring the Edit Button
//    @IBAction func EditButtonTapped(_ sender: Any?) {
//        let tableViewEditingMode = tableView.isEditing
//
//        tableView.setEditing(!tableViewEditingMode, animated: true)
//    }
//
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gun?.profiles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        Gun.saveToFile(guns: guns)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        let bgColorView = UIView()
//        let myBrown = UIColor.init(displayP3Red: 168, green: 150, blue: 119, alpha: 66)
        bgColorView.backgroundColor = UIColor.brown

        cell?.selectedBackgroundView = bgColorView
        
        reloadTableView()
    }
   
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        guard let gun = gun else {return}
        let movedRange = gun.profiles.remove(at: sourceIndexPath.row)
        
        gun.profiles.insert(movedRange, at: destinationIndexPath.row)
        Gun.saveToFile(guns: guns)
        reloadTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }
    
    @IBAction func unwindFromZeroDistance(_ segue: UIStoryboardSegue) {
        
        guard segue.source is ZeroDistanceViewController else {
            return
        }
        Gun.saveToFile(guns: guns)
        reloadTableView()
        //        **Save your presistant data with a save to file func here**
    }
    
    func reloadTableView() {
        let indexPath = tableView.indexPathForSelectedRow
        tableView.reloadData()
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
}
