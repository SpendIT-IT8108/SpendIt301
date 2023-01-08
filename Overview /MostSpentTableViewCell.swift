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
        mostSpentCollection.isScrollEnabled = false
addToCell()
//        mostSpentArray.append(mostSpentCategories(emoji: "💻", categoryName: "Laptop", price: "212 BHD"))
//        mostSpentArray.append(mostSpentCategories(emoji: "🍔", categoryName: "Food", price: "100 BHD"))
//        mostSpentArray.append(mostSpentCategories(emoji: "📚", categoryName: "Books", price: " 50 BHD"))
//        mostSpentArray.append(mostSpentCategories(emoji: "🐱", categoryName: "Cat", price: "50 BHD"))
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
    }
    func addToCell() {
        //variables declration
        let transactions : [Transaction] = Transaction.loadTransactions()
        let categories : [Category] = Category.loadCategories()!
    var   myDict = [String: Double]()
        var emoji1 : String = ""
        var categoryName1  : String = ""
        var total1 : String = ""
        //loop through the transactions
        for transaction in transactions {
            //check if the transaction category = expense
            if transaction.category.type == "Expense"
            {
               //check if category is not empty
                if myDict[transaction.category.name] != nil
                {
                    //sum the amount of the category
                    myDict[transaction.category.name]! += transaction.amount
                }else
                {
                    //append the amount itself
                    myDict[transaction.category.name] = transaction.amount
                }
            }
          
        }
        //save the sorted dictionary in a new constant
        let  DictionarySorted = myDict.sorted() { $0.value > $1.value }.prefix(3)
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
            total1 = "\(i.value) BHD"
            //append it to the array
            mostSpentArray.append(mostSpentCategories(emoji: emoji1, categoryName: categoryName1, price: total1))
        }

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.mostSpentCollection {
            //register the cell
        let cell = mostSpentCollection.dequeueReusableCell(withReuseIdentifier: "MostSpentCollectionViewCell", for: indexPath) as! MostSpentCollectionViewCell
            if mostSpentArray.count > 0 && indexPath.row < mostSpentArray.count {
            
            let category = mostSpentArray[indexPath.row]
            
            cell.setUpCell(emoji: category.emoji, categoryName: category.categoryName, sum: category.price)
        
            return cell }
            else
            
            {
                cell.setUpCell(emoji: "", categoryName: "", sum: "")
            
                return cell
            }
            
        }
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
    

