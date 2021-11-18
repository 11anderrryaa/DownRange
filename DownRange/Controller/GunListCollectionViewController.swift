//
//  GunListCollectionViewController.swift
//  DownRange
//
//  Created by Ryan Anderson on 11/15/21.
//

import UIKit

class GunListCollectionViewController: UICollectionViewController {
    var guns : [Gun] = [
        Gun(name: "Rifle Name")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
    }
    
    func getgun(at indecPath: IndexPath) -> Gun {
        guns[indecPath.row]
    }

    func showAlert() {
        if guns[0].name == "Rifle Name" {
            let infoAlertController = UIAlertController(title: "Add Rifle's name", message: nil, preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Close", style: .cancel, handler: .none)
            infoAlertController.addAction(cancelButton)
            present(infoAlertController, animated: true, completion: nil)
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return guns.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? GunCollectionViewCell else { fatalError("No Cell")}
        let gun = getgun(at: indexPath)
        cell.configure(gun: gun)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
                    self.collectionView.reloadData()
                }
            }
            alertController.addAction(cancelButton)
            alertController.addAction(submitAction)
            present(alertController, animated: true, completion: nil)
            print("Add Gun")
        } else if segue.identifier == "ToProfiles" {
            print("ToProfiles")
        }
    }
 

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
