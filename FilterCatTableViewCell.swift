//
//  FilterCatTableViewCell.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 30/12/2022.
//

import UIKit

class FilterCatTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     var catogries: [[Category]] = Category.loadSampleCategories()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catogries[section].count
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        //let symbol = categories
        cell.categoryLbl?.text = catogries[indexPath.section][indexPath.row].symbol
        cell.catogryName?.text = catogries[indexPath.section][indexPath.row].name
        
        return cell
        
    }
    
  

    @IBOutlet weak var catLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate=self
        collectionView.dataSource=self
    }

    func update(with category: Category){
        //catLbl.text=category.symbol
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.3, height: collectionView.frame.width*0.3)
    }

}
