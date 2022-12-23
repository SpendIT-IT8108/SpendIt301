//
//  FilterTransactionTableViewCell.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 23/12/2022.
//

import UIKit

class FilterTransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var filerbySwitch: UISwitch!
    @IBOutlet weak var FilterByLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func update(with transaction: Transaction){
            //transactionSymbolLable.
        FilterByLable.text=filters.first
        
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var filters=["htl", "lth"]

}
