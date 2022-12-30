//
//  FilterCatTableViewCell.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 30/12/2022.
//

import UIKit

class FilterCatTableViewCell: UITableViewCell {

    @IBOutlet weak var catLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(with category: Category){
        //catLbl.text=category.symbol
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
