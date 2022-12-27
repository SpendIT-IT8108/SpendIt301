//
//  MostTrackedCollectionViewCell.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 27/12/2022.
//

import UIKit

class MostTrackedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emojiLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    
    @IBOutlet weak var itemsNoLbl: UILabel!
    func setUpCell (emoji: String, categoryName: String, itemsNo: String){
        emojiLbl.text = emoji
        categoryLbl.text = categoryName
        itemsNoLbl.text = itemsNo
    }
}
