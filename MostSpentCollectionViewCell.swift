//
//  MostSpentCollectionViewCell.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 27/12/2022.
//

import UIKit

class MostSpentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emojiLbl: UILabel!
  
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    func setUpCell (emoji: String, categoryName: String, price: String){
        emojiLbl.text = emoji
        categoryLbl.text = categoryName
        totalLbl.text = price
    }
}
