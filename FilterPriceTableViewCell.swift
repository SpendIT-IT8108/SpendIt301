//
//  FilterPriceTableViewCell.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 30/12/2022.
//

import UIKit

class FilterPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var LtHswitch: UISwitch!
    @IBOutlet weak var HtLSwitch: UISwitch!
    @IBOutlet weak var LtHLable: UILabel!
    @IBOutlet weak var HtLLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
