//
//  GunListViewController.swift
//  DownRange
//
//  Created by Ryan Anderson on 4/4/22.
//

import UIKit

class GunListViewController: UIViewController {
    
    var counter = 1
      
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.register(
            GunCollectionViewCell.nib(),
            forCellWithReuseIdentifier: K.cellIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width/3 , height: view.frame.size.width/3)

        
    }
}

//MARK: - Delegate Methods
extension GunListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        print("You tapped Element", indexPath.row)
    }
}

//MARK: - DataSource Methods
extension GunListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellIdentifier, for: indexPath) as? GunCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.cornerRadius = 25

        cell.backgroundColor = UIColor(named: "CellBackGroundColor")
        
        
        if counter <= 12 {
            counter += 1
            
        } else {
            counter = 1
        }
        
        cell.configure(with: UIImage(named: "Image-\(counter)") ?? UIImage(), label: "test" )
        
        return cell
    }
}

//MARK: - DelegateFlowLayout Methods
extension GunListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.width / 2), height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
    }
}
