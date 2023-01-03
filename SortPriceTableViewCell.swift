//
//  SortPriceTableViewCell.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 01/01/2023.
//

import UIKit

class SortPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var LtHSwitch: UISwitch!
    @IBOutlet weak var HtLSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
