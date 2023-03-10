//
//  CategoryTVCell.swift
//  SpendIt301
//
//  Created by Kawthar Alakri on 28/12/2022.
//

import UIKit

class CategoryTVCell: UITableViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var symbolImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //update cell content with category name anc icon
    func update(with category: Category) {
        categoryNameLabel.text = category.name
        symbolImageView.image = category.icon?.image
    }
    
}
