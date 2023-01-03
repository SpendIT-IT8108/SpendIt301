//
//  CollectionViewCell.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 31/12/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var catogryIcon: UIButton!
    
   
    override func prepareForReuse() {
           super.prepareForReuse()

           // reset
        catogryIcon.isSelected = false
        catogryIcon.isHighlighted = false

       }

}
