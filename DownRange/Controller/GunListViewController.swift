//
//  GunListViewController.swift
//  DownRange
//
//  Created by Ryan Anderson on 4/4/22.
//

import UIKit

class GunListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(GunCollectionViewCell.nib(), forCellWithReuseIdentifier: K.cellIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GunListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        print("You tapped Element", indexPath.row)
    }
    
}
extension GunListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReusableCell", for: indexPath) as? GunCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: UIImage(named: "RiflePicture") ?? UIImage() )
        return cell
    }
    
    
}
