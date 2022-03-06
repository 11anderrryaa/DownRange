//
//  GunListTableViewController.swift
//  DownRange
//
//  Created by Ryan Anderson on 12/22/20.
//

import UIKit

class GunListTableViewController: UITableViewController {
    
    var gc = GunController.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gc.guns = GunController.loadFromFile()
        newUserAlert()

    }
    
    // MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gc.guns.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as? GunTableViewCell
        else { return UITableViewCell() }
        
        let gun = getGun(at: indexPath)
        cell.configure(gun: gun)
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gc.guns.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        GunController.saveToFile(guns: gc.guns)
        newUserAlert()
    }
    
    //MARK: - Method to recieve guns
    
    fileprivate func getGun(at indexPath: IndexPath) -> Gun {
        gc.guns[indexPath.row]
    }
    
    //MARK: - AlertController Methods
    
    fileprivate func newUserAlert() {
        if gc.guns.count == 0 {
            let infoAlertController = UIAlertController(title: K.Alert.newTitle, message: nil, preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: K.Alert.cancel, style: .cancel, handler: .none)
            infoAlertController.addAction(cancelButton)
            present(infoAlertController, animated: true, completion: nil)
        }
    }
    
    fileprivate func addGunAlert() {
        let alertController = UIAlertController(title: K.Alert.addGunTitle, message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = K.Alert.placeholder

        }
        let cancelButton = UIAlertAction(title: K.Alert.cancel, style: .destructive, handler: .none)
        let saveButton = UIAlertAction(title: K.Alert.save, style: .default) { (alert) in
            
            guard
                let textFieldArray = alertController.textFields,
                let nameText = textFieldArray[0].text
            else { return }
            let gun = Gun(name: nameText)
            self.gc.guns.append(gun)
            GunController.saveToFile(guns: self.gc.guns)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        alertController.addAction(cancelButton)
        alertController.addAction(saveButton)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Prepare For Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == K.addSegue {
            addGunAlert()
        }
        else if segue.identifier == K.profileSegue {
            guard
                let vc = segue.destination as? RangeTableViewController,
                let selectedIndexPath = tableView.indexPathForSelectedRow
            else { return print("error in segue") }
            
            vc.gun = gc.guns[selectedIndexPath.row]
            vc.gunController.guns = gc.guns
        }
    }
}
