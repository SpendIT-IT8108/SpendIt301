//
//  FilterCatTableViewCell.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 30/12/2022.
//

import UIKit

class FilterCatTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     var catogries: [Category] = []
    var transactions: [Transaction] = []
    var trasForCat: [Transaction]=[]
    var categoryBtn: UIButton!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catogries.count
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
         //let symbol = categories
         cell.catogryIcon.setTitle(catogries[indexPath.row].name, for: .normal)
        cell.catogryIcon.setImage(catogries[indexPath.row].icon?.image, for: .normal)
         categoryBtn=cell.catogryIcon!
         return cell
        
    }
    
  

    @IBOutlet weak var catLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate=self
        collectionView.dataSource=self
        
        transactions = Transaction.loadTransactions()
        
        
        if let saveCategory=Category.loadCategories(){
            catogries=saveCategory

        }else{
            catogries=Category.loadSampleCategories()
        }
    }

    func update(with category: Category){
      
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //custom cell size
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
    }

}

