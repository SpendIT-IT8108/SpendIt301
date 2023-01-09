//
//  MostSpentCollectionViewCell.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 28/12/2022.
//

import UIKit

class MostSpentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emojiLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var spentSumLbl: UILabel!
    //function to set up the cell with requird info from transactions
    func setUpCell (emoji: String, categoryName: String, sum: String){
        emojiLbl.text = emoji
        categoryLbl.text = categoryName
        spentSumLbl.text = sum
    }
}
