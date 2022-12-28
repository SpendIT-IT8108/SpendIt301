//
//  MostSpentTableViewCell.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 28/12/2022.
//

import UIKit

class MostSpentTableViewCell: UITableViewCell, UICollectionViewDataSource,UICollectionViewDelegate  {

    

    @IBOutlet weak var mostSpentCollection: UICollectionView!
    var mostSpentArray = [mostSpentCategories]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        mostSpentCollection.delegate = self
        mostSpentCollection.dataSource = self
        

        //define item size
        let itemSize =
           NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
           heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//define group size
        let groupSize =
           NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
           heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
           groupSize, subitem: item, count: 3)
//define section size
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8,
           bottom: 8, trailing: 8)
        section.interGroupSpacing = 8

        mostSpentCollection.collectionViewLayout =
           UICollectionViewCompositionalLayout(section: section)
        

        mostSpentArray.append(mostSpentCategories(emoji: "💻", categoryName: "Laptop", price: "212 BHD"))
        mostSpentArray.append(mostSpentCategories(emoji: "🍔", categoryName: "Food", price: "100 BHD"))
        mostSpentArray.append(mostSpentCategories(emoji: "📚", categoryName: "Books", price: " 50 BHD"))
        mostSpentArray.append(mostSpentCategories(emoji: "🐱", categoryName: "Cat", price: "50 BHD"))
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.mostSpentCollection {
            //register the cell
        let cell = mostSpentCollection.dequeueReusableCell(withReuseIdentifier: "MostSpentCollectionViewCell", for: indexPath) as! MostSpentCollectionViewCell
        let category = mostSpentArray[indexPath.row]
            cell.setUpCell(emoji: category.emoji, categoryName: category.categoryName, sum: category.price)
        
            return cell }
        else
        
        {
            return UICollectionViewCell()
        }
    }
    
   

}
    struct mostSpentCategories {
        let emoji : String
        let categoryName: String
        let price : String
    }
    

