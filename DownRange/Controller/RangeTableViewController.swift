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
    var profiles : [Profile] {
        guard let gun = gun else {return []}
        return gun.profiles
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    // MARK: - Table view data source

    @IBAction func addYards(_ sender: UIBarButtonItem) {
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
        
        let profile = profiles[indexPath.row]
        var selectedProfile : Profile?
        if let indexPath = tableView.indexPathForSelectedRow {
            selectedProfile = profiles[indexPath.row]
        }
        
        cell.updateView(with: profile, selectedProfile: selectedProfile)
        cell.yardsButton.titleLabel?.text = "???"
        cell.yardsButton.title(for: .normal)
        return cell
    }
    // configuring the Edit Button
    @IBAction func EditButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gun?.profiles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        reloadTableView()
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        guard let gun = gun else {return}
        let movedRange = gun.profiles.remove(at: sourceIndexPath.row)
        
        gun.profiles.insert(movedRange, at: destinationIndexPath.row)
        reloadTableView()
    }
    
  override func viewWillAppear(_ animated: Bool) {
    reloadTableView()
       }
    
    @IBAction func unwindFromZeroDistance(_ segue: UIStoryboardSegue) {
        
        guard segue.source is ZeroDistanceViewController else {
            return
        }
        
        reloadTableView()
//        **Save your presistant data with a save to file func here**
    }
    
    func reloadTableView() {
        let indexPath = tableView.indexPathForSelectedRow
        tableView.reloadData()
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
}
