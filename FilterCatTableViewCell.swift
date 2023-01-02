//
//  FilterCatTableViewCell.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 30/12/2022.
//

import UIKit

class FilterCatTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     var catogries: [Category] = Category.loadSampleCategories()
    var transactions: [Transaction] = []
    var trasForCat: [Transaction]=[]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catogries.count
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var categoryBtn: UIButton!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        //let symbol = categories
        cell.catogryIcon.setTitle(catogries[indexPath.row].name, for: .normal)
        cell.catogryIcon.setImage(catogries[indexPath.row].icon, for: .normal)
        categoryBtn=cell.catogryIcon!
        return cell
        
    }
    @IBAction func categoryPressed(_ sender: Any) {
        //categoryBtn.isEnabled=false
       // print()
    
    }
    
  

    @IBOutlet weak var catLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate=self
        collectionView.dataSource=self
        
        if let saveTransaction=Transaction.loadTransaction(){
            transactions=saveTransaction

        }else{
            transactions=Transaction.loadSampleTransacion()
        }
        
        
    }

    func update(with category: Category){
        //catLbl.text=category.symbol
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
       
    }

}

