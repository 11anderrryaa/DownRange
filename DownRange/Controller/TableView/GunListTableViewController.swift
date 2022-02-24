//
//  GunListTableViewController.swift
//  DownRange
//
//  Created by Ryan Anderson on 12/22/20.
//

import UIKit

class GunListTableViewController: UITableViewController {
    
    var guns: [Gun]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guns = Gun.loadFromFile()
        showAlert()
    }
    
    // MARK: - Table view data source
    func setTableViewBackgroundGradient(sender: UITableViewController, _ topColor:UIColor, _ bottomColor:UIColor) {

        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations = [NSNumber(0.0), NSNumber(1.0)]

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations

        gradientLayer.frame = sender.tableView.bounds
        let backgroundView = UIView(frame: sender.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        sender.tableView.backgroundView = backgroundView
    }
    
    func showAlert() {
        if guns.count == 0 {
            let infoAlertController = UIAlertController(title: "Add Rifle's zero'd range by pushing the + button", message: nil, preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Close", style: .cancel, handler: .none)
            infoAlertController.addAction(cancelButton)
            present(infoAlertController, animated: true, completion: nil)
        }
    }
    
    func getGun(at indexPath: IndexPath) -> Gun {
        guns[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guns.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GunCell", for: indexPath) as? GunTableViewCell else {fatalError("No Cell!")}
        let gun = getGun(at: indexPath)
        cell.configure(gun: gun)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guns.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        Gun.saveToFile(guns: guns)
        showAlert()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "AddGun" {
            let alertController = UIAlertController(title: "Enter Rifle", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.placeholder = "Rifle Name💥🔫"
                textField.textAlignment = .center
            }
            let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: .none)
            let submitAction = UIAlertAction(title: "Submit", style: .default) { (alert) in
                guard let textFieldArray = alertController.textFields, let nameText = textFieldArray[0].text
                else {return}
                let gun = Gun(name: nameText)
                self.guns.append(gun)
                Gun.saveToFile(guns: self.guns)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            alertController.addAction(cancelButton)
            alertController.addAction(submitAction)
            present(alertController, animated: true, completion: nil)
        }
        else if segue.identifier == "ToProfiles" {
            guard let vc = segue.destination as? RangeTableViewController,
                  let selectedIndexPath = tableView.indexPathForSelectedRow else
                  {return print("error in segue")}
            vc.gun = guns[selectedIndexPath.row]
            vc.guns = guns
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath)
        //        let bgColorView = UIView()
        //        bgColorView.backgroundColor = UIColor.brown
        //        cell?.selectedBackgroundView = bgColorView
    }
}
