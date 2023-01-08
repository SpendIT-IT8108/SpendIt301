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
        mostTrackedCollection.isScrollEnabled = false
addToCell()
//        mostTrackedArray.append(mostTrackedCategories(emoji: "🍔", categoryName: "Food", itemsNo: "5 times"))
//        mostTrackedArray.append(mostTrackedCategories(emoji: "📚", categoryName: "Books", itemsNo: "3 times"))
//        mostTrackedArray.append(mostTrackedCategories(emoji: "🐱", categoryName: "Cat", itemsNo: "2 times"))
    }
    func addToCell() {
        //variables declration
        let transactions : [Transaction] = Transaction.loadTransactions()
        let categories : [Category] = Category.loadSampleCategories()
    var   myDict = [String: Int]()
        var emoji1 : String = ""
        var categoryName1  : String = ""
        var itemsNo1 : String = ""
       // var counter : Int = 0
        //loop through the transactions
        for transaction in transactions {
            //check if the transaction category = expense
            if transaction.category.type == "Expense"
            {
               //check if category is not empty
                if myDict[transaction.category.name] != nil
                {
                    //sum the amount of the category
                    myDict[transaction.category.name]! += 1
                }else
                {
                    //append the amount itself
                    myDict[transaction.category.name] = 1
                }
            }
          
        }
        //save the sorted dictionary in a new constant
        let  DictionarySorted =    myDict.sorted() { $0.value > $1.value }.prefix(3)
        //loop through the dictionary to assign the variables
        for i in DictionarySorted {
            //loop through the categories to get the category symbol / emoji
            for transaction in transactions {
                
                //check  the category name
                if i.key == transaction.category.name{
                    //asign the symbol to the variable
                    emoji1 = transaction.category.symbol
                }
            }
            //assign the category name and the total to the variables
            categoryName1 =  i.key
            itemsNo1 = "\(i.value) times"
            //append it to the array
            mostTrackedArray.append(mostTrackedCategories(emoji: emoji1, categoryName: categoryName1, itemsNo: itemsNo1))
        }

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
                if mostTrackedArray.count > 0 && indexPath.row < mostTrackedArray.count {
                let category = mostTrackedArray[indexPath.row]
                cell.setUpCell(emoji: category.emoji, categoryName: category.categoryName, itemsNo: category.itemsNo)
                
            return cell
                
                }else{
                    cell.setUpCell(emoji: "", categoryName: "", itemsNo: "")
                
                    return cell
                }
                
                
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
