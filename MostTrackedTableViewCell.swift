//
//  MostTrackedTableViewCell.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 28/12/2022.
//

import UIKit

class MostTrackedTableViewCell: UITableViewCell, UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var mostTrackedCollection: UICollectionView!
    var mostTrackedArray = [mostTrackedCategories]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mostTrackedCollection.delegate = self
        mostTrackedCollection.dataSource = self
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

        mostTrackedCollection.collectionViewLayout =
           UICollectionViewCompositionalLayout(section: section)
        
        mostTrackedArray.append(mostTrackedCategories(emoji: "🍔", categoryName: "Food", itemsNo: "5 times"))
        mostTrackedArray.append(mostTrackedCategories(emoji: "📚", categoryName: "Books", itemsNo: "3 times"))
        mostTrackedArray.append(mostTrackedCategories(emoji: "🐱", categoryName: "Cat", itemsNo: "2 times"))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
     
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.mostTrackedCollection {
        
        let cell = mostTrackedCollection.dequeueReusableCell(withReuseIdentifier: "MostTrackedCollectionViewCell", for: indexPath) as! MostTrackedCollectionViewCell
            
            let category = mostTrackedArray[indexPath.row]
            cell.setUpCell(emoji: category.emoji, categoryName: category.categoryName, itemsNo: category.itemsNo)
            
        return cell
            
        }else
        
        {
            return UICollectionViewCell()
        }
    }
    struct mostTrackedCategories {
        let emoji : String
        let categoryName: String
        let itemsNo : String
    }
    

}
